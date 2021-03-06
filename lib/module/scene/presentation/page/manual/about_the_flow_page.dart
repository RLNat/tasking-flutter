import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutTheFlowPage extends StatelessWidget {
  const AboutTheFlowPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('フローについて'),
      ),
      body: Container(
        child: const Markdown(
          data: '''
## フローとは？
フローとは、タスクに進捗状況のことです。

フローに対してオペレーションを複数追加することができ、追加したオペレーションを進捗順に並び替えることで、シーンに応じたタスクのフローを編集することができます。

並び順の最上位にあるオペレーションは、対象シーンのタスクを作成した時に、デフォルトで割り当てられるオペレーションとなります。

## オペレーションネームについて
オペレーションに設定するオペレーションネームには、同じ名前を使うことができません。

## オペレーションの削除について
既にタスクに割り当てられているオペレーションは削除することができません。
また、並び順の最上位にあるオペレーションも削除することができません。
          ''',
        ),
        color: Colors.white,
      ),
    );
  }
}
