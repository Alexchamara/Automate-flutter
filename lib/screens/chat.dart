import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const ChatPagePortrait();
        } else {
          return const ChatPageLandscape();
        }
      },
    );
  }
}

//ChatPagePortrait
class ChatPagePortrait extends StatelessWidget {
  const ChatPagePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 10), child: EmptyImg()),
          EmptyChatBtn(
            borderColor: Colors.grey.withOpacity(0.5),
            borderWidth: 1.0,
            btnColor: Colors.grey[400],
            btnTitle: 'Post an Ad',
          ),
          EmptyChatBtn(
            borderColor: Theme.of(context).primaryColor,
            borderWidth: 1.0,
            btnColor: Theme.of(context).primaryColor,
            btnTitle: 'Browse Ads',
          ),
        ],
      ),
    );
  }
}

//ChatPageLandscape
class ChatPageLandscape extends StatelessWidget {
  const ChatPageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 10), child: EmptyImg()),
          Column(
            children: [
              EmptyChatBtn(
                borderColor: Colors.grey.withOpacity(0.5),
                borderWidth: 1.0,
                btnColor: Colors.grey[400],
                btnTitle: 'Post an Ad',
              ),
              EmptyChatBtn(
                borderColor: Theme.of(context).primaryColor,
                borderWidth: 1.0,
                btnColor: Theme.of(context).primaryColor,
                btnTitle: 'Browse Ads',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Empty Feilds
class EmptyImg extends StatelessWidget {
  const EmptyImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('No conversations yet!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.asset('images/chatEmptyImg.png',
              width: 150.0, height: 150.0),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Click "Chat" on an ad or post your own ad to start chatting.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14.0,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

//EmptyChatBtn
class EmptyChatBtn extends StatelessWidget {
  final borderColor;
  final borderWidth;
  final btnColor;
  final btnTitle;
  final String navigaterTo = '/chat';
  const EmptyChatBtn(
      {super.key,
      this.borderColor,
      this.borderWidth,
      this.btnColor,
      this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: borderColor, // Border color
                width: borderWidth, // Border width
              ),
            ),
            child: MaterialButton(
              height: 50,
              minWidth: 290,
              onPressed: () {
                Navigator.pushReplacementNamed(context, navigaterTo);
              },
              // color: Theme.of(context).primaryColor,
              color: btnColor,
              child: Text(
                btnTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
