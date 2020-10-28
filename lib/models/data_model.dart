import 'package:hookup4u/models/user_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

class Notifications {
  final User sender;
  final String time;
  final bool unread;

  Notifications({
    this.sender,
    this.time,
    this.unread,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'John',
  age: 30,
  address: 'North central New York 223',
  imageUrl: [
    "asset/userPictures/currentUser/currentUser1.jpeg",
    "asset/userPictures/currentUser/currentUser2.jpeg",
    "asset/userPictures/currentUser/currentUser3.jpeg",
    "asset/userPictures/currentUser/currentUser4.jpeg"
  ],
);

// USERS
final User bunny = User(
    id: 1,
    name: 'Bunny',
    age: 26,
    address: 'Niagara Falls 1123',
    imageUrl: ["asset/userPictures/otherUsers/bunny1.jpeg"]);
final User luv = User(
    id: 2,
    name: 'Luv',
    age: 22,
    address: 'New York 223',
    imageUrl: ["asset/userPictures/otherUsers/luv.jpeg"]);
final User eliana =
    User(id: 3, name: 'Eliana', age: 25, address: 'New York 225', imageUrl: [
  "asset/userPictures/otherUsers/eliana1.jpeg",
  "asset/userPictures/otherUsers/eliana2.jpeg",
]);
final User eliora =
    User(id: 4, name: 'Eliora', age: 23, address: 'New York 225', imageUrl: [
  "asset/userPictures/otherUsers/eliora1.jpeg",
  "asset/userPictures/otherUsers/eliora2.jpeg",
  "asset/userPictures/otherUsers/eliora3.jpeg",
]);
final User sam =
    User(id: 5, name: 'Sam', age: 22, address: 'New York 223', imageUrl: [
  "asset/userPictures/otherUsers/sam.jpeg",
]);
final User tom =
    User(id: 6, name: 'Tom', age: 21, address: 'New York 223', imageUrl: [
  "asset/userPictures/otherUsers/tom1.jpeg",
  "asset/userPictures/otherUsers/tom2.jpeg",
  "asset/userPictures/otherUsers/tom.jpeg",
]);
final User lois =
    User(id: 7, name: 'Lois', age: 20, address: 'New York 223', imageUrl: [
  "asset/userPictures/otherUsers/lois1.jpeg",
  "asset/userPictures/otherUsers/lois2.jpeg",
]);

// FAVORITE CONTACTS
List<User> users = [lois, eliana, luv, eliora, sam, tom, bunny];
List<User> matches = [
  bunny,
  sam,
  luv,
  lois,
];

List<Notifications> notifications = [
  Notifications(
    sender: luv,
    time: '5:30 PM',
    unread: true,
  ),
  Notifications(
    sender: bunny,
    time: '4:30 PM',
    unread: true,
  ),
  Notifications(
    sender: lois,
    time: '3:30 PM',
    unread: false,
  ),
  Notifications(
    sender: tom,
    time: '2:30 PM',
    unread: true,
  ),
  Notifications(
    sender: eliora,
    time: '1:30 PM',
    unread: false,
  ),
  Notifications(
    sender: eliana,
    time: '12:30 PM',
    unread: false,
  ),
  Notifications(
    sender: sam,
    time: '11:30 AM',
    unread: false,
  ),
];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: luv,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: bunny,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: eliana,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: tom,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: eliora,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: lois,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: luv,
    time: '2:45 PM',
    text: 'How\'s the bunny?',
    unread: true,
  ),
  Message(
    sender: luv,
    time: '2:15 PM',
    text: 'What are u doing ?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '1:30 PM',
    text: 'I am fine.',
    unread: false,
  ),
  Message(
    sender: luv,
    time: '1:00 PM',
    text: 'Hey How are you?.',
    unread: true,
  ),
];
