import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/room_provider.dart';
import 'package:provider/provider.dart';

import '../../models/room.dart';

class AddEditRoomScreen extends StatefulWidget {
  static const routeName = '/rooms/add-edit-room';
  const AddEditRoomScreen({super.key});

  @override
  State<AddEditRoomScreen> createState() => _AddEditRoomScreenState();
}

class _AddEditRoomScreenState extends State<AddEditRoomScreen> {
  final _form = GlobalKey<FormState>();
  bool _needInit = true;
  int roomId = -1;

  final nameContorller = TextEditingController();

  void _saveForm(BuildContext context) {
    print('Save form');

    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    if (roomId == -1) {
      Provider.of<RoomsProvider>(context, listen: false)
          .addRoom(
        Room(
          nameContorller.text,
        ),
      )
          .then((value) {
        print('Room added');
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<RoomsProvider>(context, listen: false)
          .updateRoom(
        Room(
          nameContorller.text,
          id: roomId,
        ),
      )
          .then((value) {
        print('Room updated');
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_needInit) {
      _needInit = false;
      final roomId = ModalRoute.of(context)!.settings.arguments;
      if (roomId != null) {
        final room = Provider.of<RoomsProvider>(context, listen: false)
            .getRoomById(roomId as int);
        nameContorller.text = room.name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveForm(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  //room name
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    } else if (value.startsWith(RegExp(r'[0-9]'))) {
                      return 'Name can\'t start with a number';
                    }
                    return null;
                  },
                  controller: nameContorller,
                  decoration: const InputDecoration(labelText: 'Room name'),
                  maxLines: 1,
                  onFieldSubmitted: (_) => _saveForm(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          _saveForm(context);
                        },
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
