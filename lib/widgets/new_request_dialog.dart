import 'package:flutter/material.dart';
import '../main.dart'; // For HoverScale

class NewRequestDialog extends StatefulWidget {
  const NewRequestDialog({super.key});

  @override
  State<NewRequestDialog> createState() => _NewRequestDialogState();
}

class _NewRequestDialogState extends State<NewRequestDialog> {
  String selectedCategory = 'TECH & DEV';
  int scutes = 1;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _submit() {
    if (_titleController.text.trim().isEmpty || _descController.text.trim().isEmpty) return;
    Navigator.pop(context, {
      'title': _titleController.text.trim().toUpperCase(),
      'tag': selectedCategory,
      'description': _descController.text.trim().toUpperCase(),
      'scutes': scutes,
      'userInitial': 'T',
      'timeAgo': 'Just now',
      'tagColor': selectedCategory == 'TECH & DEV' ? Colors.black : 
                  selectedCategory == 'CREATIVE ARTS' ? Colors.blue : 
                  selectedCategory == 'MISCELLANEOUS' ? Colors.green : Colors.orange,
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w900,
          fontSize: 10,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildCategoryBtn(String title) {
    bool isSelected = selectedCategory == title;
    return Expanded(
      child: HoverScale(
        scale: 1.02,
        onTap: () => setState(() => selectedCategory = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE03A3E) : Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(2, 2)),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [
            BoxShadow(color: Color(0xFFE03A3E), offset: Offset(10, 10)),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD200),
                  border: Border(bottom: BorderSide(color: Colors.black, width: 4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'NEW REQUEST',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                    HoverScale(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(Icons.close, size: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('REQUEST TITLE'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: TextField(
                        controller: _titleController,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'EX: NEED REACT HELP',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                    _buildLabel('SHELLP CATEGORY'),
                    Row(
                      children: [
                        _buildCategoryBtn('TECH & DEV'),
                        const SizedBox(width: 10),
                        _buildCategoryBtn('MISCELLANEOUS'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildCategoryBtn('CREATIVE ARTS'),
                        const SizedBox(width: 10),
                        _buildCategoryBtn('PROFESSIONALISM'),
                      ],
                    ),
                    _buildLabel('TRADE DETAILS'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: TextField(
                        controller: _descController,
                        maxLines: 4,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'EXPLAIN YOUR TRADE... BE SPECIFIC!',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    _buildLabel('SCUTE BOUNTY'),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(2, 2)),
                        ],
                        color: Colors.white, // need to set color to have shadow
                      ),
                      child: Row(
                        children: [
                          HoverScale(
                            onTap: () {
                              if (scutes > 1) setState(() => scutes--);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              alignment: Alignment.center,
                              child: const Text('-', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$scutes SCUTES',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          HoverScale(
                            onTap: () => setState(() => scutes++),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              alignment: Alignment.center,
                              child: const Text('+', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    HoverScale(
                      onTap: _submit,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFFFD200), offset: Offset(6, 6)),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'POST TO THE FEED',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.send_outlined, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Padding for the yellow shadow
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
