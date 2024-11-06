import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_bar.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_colors.dart';
import 'package:flutter_speech_to_text_tutorial/consts/assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home Screen/Lanugage Selection/app_localizations.dart';
import 'widgets/editing_notes.dart';

// Note model
class Note {
  int id;
  String content;
  DateTime createdAt; // Add a DateTime property for creation date

  Note({
    required this.id,
    required this.content,
    required this.createdAt, // Add createdAt to the constructor
  });

  // Convert a Note into a Map for JSON encoding
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  // Create a Note from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']), // Parse ISO 8601 string to DateTime
    );
  }
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  Map<String, List<Note>> _groupedNotes = {};
  int _nextId = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes') ?? '[]';
    final List<dynamic> notesList = json.decode(notesJson);
    setState(() {
      _notes = notesList.map((json) => Note.fromMap(json)).toList();
      _notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _filterNotes();
      if (_notes.isNotEmpty) {
        _nextId = _notes.map((note) => note.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = json.encode(_notes.map((note) => note.toMap()).toList());
    await prefs.setString('notes', notesJson);
  }

  void _addNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditScreen(note: null),
      ),
    );
    if (newNote != null) {
      setState(() {
        _notes.add(Note(
          id: _nextId++,
          content: newNote,
          createdAt: DateTime.now(),
        ));
        _notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        _filterNotes();
        _saveNotes();
      });
    }
  }

  void _editNote(Note note) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(note: note),
      ),
    );
    if (updatedNote != null) {
      setState(() {
        note.content = updatedNote;
        _notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        _filterNotes();
        _saveNotes();
      });
    }
  }

  void _deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
      _filterNotes();
      _saveNotes();
    });
  }

  void _filterNotes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      final date = _parseDate(query);
      if (date != null) {
        _filteredNotes = _notes
            .where((note) =>
        note.createdAt.year == date.year &&
            note.createdAt.month == date.month &&
            note.createdAt.day == date.day)
            .toList();
      } else {
        _filteredNotes = _notes
            .where((note) =>
            note.content.toLowerCase().contains(query))
            .toList();
      }
      _groupNotesByDate();
    });
  }

  DateTime? _parseDate(String query) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(query, true);
    } catch (e) {
      try {
        return DateFormat('MM/dd/yyyy').parseStrict(query, true);
      } catch (e) {
        try {
          return DateFormat('dd MMM yyyy').parseStrict(query, true);
        } catch (e) {
          return null;
        }
      }
    }
  }

  void _groupNotesByDate() {
    _groupedNotes = {};
    for (var note in _filteredNotes) {
      final dateKey = DateFormat.yMMMd().format(note.createdAt);
      if (_groupedNotes[dateKey] == null) {
        _groupedNotes[dateKey] = [];
      }
      _groupedNotes[dateKey]!.add(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('notes'),
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 7,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: AppColors().fifthTileColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: AppLocalizations.of(context).translate('search'),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: ListTile(
                leading: Image.asset(
                  AppAssets.notes,
                  height: 35,
                  width: 35,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('welcomeNote'),
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 5,
            thickness: 2,
            color: Colors.grey,
            indent: 30,
            endIndent: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              children: _groupedNotes.entries.map((entry) {
                final date = entry.key;
                final notes = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
                      child: Text(
                        date,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    ...notes.map((note) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: AppColors().fifthTileColor,
                        elevation: 4,
                        child: ListTile(
                          leading: Text(
                            '${_filteredNotes.indexOf(note) + 1}',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                          title: Text(
                            note.content.length > 15
                                ? '${note.content.substring(0, 15)}...'
                                : note.content,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                            ),
                          ),
                          onTap: () => _editNote(note),
                          trailing: IconButton(
                            icon: Image.asset(
                              AppAssets.deleteRed,
                              height: 25,
                              width: 25,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            onPressed: () => _deleteNote(note),
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 63,
        width: 63,
        child: FloatingActionButton(
          backgroundColor: AppColors().fifthTileColor,
          onPressed: _addNote,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
