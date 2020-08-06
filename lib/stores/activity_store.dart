import 'package:mobx/mobx.dart';

part 'activity_store.g.dart';
class ActivityStore = _ActivityStore with _$ActivityStore;

abstract class _ActivityStore with Store{
  List<bool> friendRequest = [
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> likeList = [
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> commentList = [
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> mentionList = [
    true,
    true,
    true,
    true,
    true,
  ];

  List teams = [
    {
      'name': 'Team one',
      'players': [
        {
          'name': 'Team one player one',
        },
        {
          'name': 'Team one player two',
        },
        {
          'name': 'Team one player three',
        },
      ]
    },
    {
      'name': 'Team two',
      'players': [
        {
          'name': 'Team two player one',
        },
        {
          'name': 'Team two player one',
        },
        {
          'name': 'Team two player three',
        },
      ]
    },
  ];
}