import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;

/// 程序入口，运行应用
void main() {
  runApp(const MyApp());
}

/// 应用的根组件，是一个无状态组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 这个小部件是您应用程序的根部件。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 应用程序的标题
      title: 'Emoji Mix',
      theme: ThemeData(
        // 这是应用程序的主题。
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 103, 58, 183),
        ),
      ),
      // 应用的主页
      home: const MyHomePage(title: '🐢EmojiMix | 混合两个emoji表情'),
    );
  }
}

/// 应用的主页，是一个有状态组件
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // 此小部件的标题
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 主页的状态类
class _MyHomePageState extends State<MyHomePage> {
  // 控制列表是否显示
  bool _isListVisible = false;
  // 提示文本列表
  final List<String> _tips = ['这是第一条提示', '这是第二条提示', '这是第三条提示'];
  // 当前的提示索引
  int _currentTipIndex = 0;
  // 提示栏是否显示
  bool _isTipVisible = false;
  // 定时器
  Timer? _timer;
  // 喜欢的项目列表
  final List<String> likes = ['喜欢的项目1', '喜欢的项目2', '喜欢的项目3'];
  // emojis
  Map emojis = {
    "😀": [128512],
    "😃": [128515],
    "😄": [128516],
    "😁": [128513],
    "😆": [128518],
    "😅": [128517],
    "😂": [128514],
    "🤣": [129315],
    "😭": [128557],
    "😗": [128535],
    "😙": [128537],
    "😚": [128538],
    "😘": [128536],
    "🥰": [129392],
    "😍": [128525],
    "🤩": [129321],
    "🥳": [129395],
    "🤗": [129303],
    "🙃": [128579],
    "🙂": [128578],
    "🥲": [129394],
    "🥹": [129401],
    "☺": [9786, 65039],
    "😊": [128522],
    "😏": [128527],
    "😌": [128524],
    "😉": [128521],
    "🫢": [129762],
    "🤭": [129325],
    "😶": [128566, 8205, 127787, 65039],
    "😐": [128528],
    "😑": [128529],
    "😔": [128532],
    "😋": [128523],
    "😛": [128539],
    "😝": [128541],
    "😜": [128540],
    "🤪": [129322],
    "🫡": [129761],
    "🤔": [129300],
    "🤨": [129320],
    "🧐": [129488],
    "🙄": [128580],
    "😒": [128530],
    "😤": [128548],
    "😠": [128544],
    "😡": [128545],
    "🤬": [129324],
    "☹": [9785, 65039],
    "🙁": [128577],
    "🫤": [129764],
    "😕": [128533],
    "😟": [128543],
    "🥺": [129402],
    "😳": [128563],
    "😬": [128556],
    "🤐": [129296],
    "🤫": [129323],
    "😰": [128560],
    "😨": [128552],
    "😧": [128551],
    "😦": [128550],
    "😮": [128558, 8205, 128168],
    "😯": [128559],
    "😲": [128562],
    "🫣": [129763],
    "😱": [128561],
    "🤯": [129327],
    "😢": [128546],
    "😥": [128549],
    "😓": [128531],
    "😞": [128542],
    "😖": [128534],
    "😣": [128547],
    "😩": [128553],
    "😫": [128555],
    "🤤": [129316],
    "🥱": [129393],
    "😴": [128564],
    "😪": [128554],
    "🌛": [127771],
    "🌜": [127772],
    "🌚": [127770],
    "🌝": [127773],
    "🌞": [127774],
    "🤢": [129314],
    "🤮": [129326],
    "🤧": [129319],
    "🤒": [129298],
    "🤕": [129301],
    "🥴": [129396],
    "🫠": [129760],
    "🫥": [129765],
    "😵": [128565],
    "🥵": [129397],
    "🥶": [129398],
    "😷": [128567],
    "😇": [128519],
    "🤠": [129312],
    "🤑": [129297],
    "😎": [128526],
    "🤓": [129299],
    "🥸": [129400],
    "🤥": [129317],
    "🤡": [129313],
    "👻": [128123],
    "💩": [128169],
    "👽": [128125],
    "🤖": [129302],
    "🎃": [127875],
    "😈": [128520],
    "👿": [128127],
    "💥": [128165],
    "💯": [128175],
    "🫧": [129767],
    "🕳": [128371, 65039],
    "🎊": [127882],
    "❤": [10084, 65039, 8205, 129657],
    "🧡": [129505],
    "💛": [128155],
    "💚": [128154],
    "💙": [128153],
    "💜": [128156],
    "🤎": [129294],
    "🖤": [128420],
    "🤍": [129293],
    "♥": [9829, 65039],
    "💘": [128152],
    "💝": [128157],
    "💖": [128150],
    "💗": [128151],
    "💓": [128147],
    "💞": [128158],
    "💕": [128149],
    "💌": [128140],
    "💟": [128159],
    "❣": [10083, 65039],
    "💔": [128148],
    "💋": [128139],
    "🧠": [129504],
    "🫀": [129728],
    "🫁": [129729],
    "🩸": [129656],
    "🦠": [129440],
    "🦷": [129463],
    "🦴": [129460],
    "💀": [128128],
    "👀": [128064],
    "👁": [128065, 65039],
    "🫦": [129766],
    "💐": [128144],
    "🌹": [127801],
    "🌺": [127802],
    "🌷": [127799],
    "🌸": [127800],
    "💮": [128174],
    "🏵": [127989, 65039],
    "🌻": [127803],
    "🌼": [127804],
    "🍄": [127812],
    "🌱": [127793],
    "🌿": [127807],
    "🍃": [127811],
    "🍀": [127808],
    "🪴": [129716],
    "🌵": [127797],
    "🌴": [127796],
    "🌳": [127795],
    "🌲": [127794],
    "🪹": [129721],
    "🪵": [129717],
    "🪨": [129704],
    "⛄": [9924],
    "🌊": [127754],
    "🌬": [127788, 65039],
    "🌀": [127744],
    "🌪": [127786, 65039],
    "🔥": [128293],
    "☁": [9729, 65039],
    "🌋": [127755],
    "🏖": [127958, 65039],
    "⚡": [9889],
    "⛅": [9925],
    "🌩": [127785, 65039],
    "🌧": [127783, 65039],
    "💧": [128167],
    "🌈": [127752],
    "⭐": [11088],
    "🌟": [127775],
    "💫": [128171],
    "☄": [9732, 65039],
    "🪐": [129680],
    "🌍": [127757],
    "🙈": [128584],
    "🐵": [128053],
    "🦁": [129409],
    "🐯": [128047],
    "🐱": [128049],
    "🐶": [128054],
    "🐻": [128059],
    "🐨": [128040],
    "🐼": [128060],
    "🐭": [128045],
    "🐰": [128048],
    "🦝": [129437],
    "🐷": [128055],
    "🦄": [129412],
    "🐢": [128034],
    "🐩": [128041],
    "🐐": [128016],
    "🦌": [129420],
    "🦙": [129433],
    "🦥": [129445],
    "🦔": [129428],
    "🦇": [129415],
    "🐦": [128038],
    "🕊": [128330, 65039],
    "🦉": [129417],
    "🦩": [129449],
    "🐧": [128039],
    "🐟": [128031],
    "🦞": [129438],
    "🦀": [129408],
    "🐙": [128025],
    "🪸": [129720],
    "🦂": [129410],
    "🕷": [128375, 65039],
    "🐚": [128026],
    "🐌": [128012],
    "🦗": [129431],
    "🪲": [129714],
    "🪳": [129715],
    "🐝": [128029],
    "🐞": [128030],
    "🦋": [129419],
    "🐾": [128062],
    "🍓": [127827],
    "🍒": [127826],
    "🍉": [127817],
    "🍊": [127818],
    "🥭": [129389],
    "🍍": [127821],
    "🍌": [127820],
    "🍋": [127819],
    "🍈": [127816],
    "🍐": [127824],
    "🥝": [129373],
    "🫒": [129746],
    "🫐": [129744],
    "🍇": [127815],
    "🥥": [129381],
    "🍅": [127813],
    "🌶": [127798, 65039],
    "🥕": [129365],
    "🍠": [127840],
    "🧅": [129477],
    "🌽": [127805],
    "🥦": [129382],
    "🥒": [129362],
    "🫑": [129745],
    "🥑": [129361],
    "🧄": [129476],
    "🥔": [129364],
    "🫘": [129752],
    "🌰": [127792],
    "🥜": [129372],
    "🍞": [127838],
    "🫓": [129747],
    "🥐": [129360],
    "🥯": [129391],
    "🥞": [129374],
    "🍳": [127859],
    "🧀": [129472],
    "🥩": [129385],
    "🍖": [127830],
    "🍔": [127828],
    "🌭": [127789],
    "🥪": [129386],
    "🥨": [129384],
    "🍟": [127839],
    "🫔": [129748],
    "🌮": [127790],
    "🌯": [127791],
    "🥙": [129369],
    "🧆": [129478],
    "🥘": [129368],
    "🍝": [127837],
    "🥫": [129387],
    "🫕": [129749],
    "🥣": [129379],
    "🥗": [129367],
    "🍲": [127858],
    "🍛": [127835],
    "🍜": [127836],
    "🍣": [127843],
    "🍤": [127844],
    "🍚": [127834],
    "🍱": [127857],
    "🍙": [127833],
    "🍘": [127832],
    "🍥": [127845],
    "🥠": [129376],
    "🍧": [127847],
    "🍨": [127848],
    "🍦": [127846],
    "🍰": [127856],
    "🎂": [127874],
    "🧁": [129473],
    "🍫": [127851],
    "🍩": [127849],
    "🍪": [127850],
    "🧂": [129474],
    "🍿": [127871],
    "🧋": [129483],
    "🍼": [127868],
    "🍵": [127861],
    "☕": [9749],
    "🧉": [129481],
    "🍹": [127865],
    "🍽": [127869, 65039],
    "🛑": [128721],
    "🚨": [128680],
    "🛟": [128735],
    "⚓": [9875],
    "🚗": [128663],
    "🏎": [127950, 65039],
    "🚕": [128661],
    "🚌": [128652],
    "🚂": [128642],
    "🛸": [128760],
    "🚀": [128640],
    "🎢": [127906],
    "🎡": [127905],
    "🎪": [127914],
    "🏠": [127968],
    "🌇": [127751],
    "🎈": [127880],
    "🎀": [127872],
    "🎁": [127873],
    "🪩": [129705],
    "🥇": [129351],
    "🥈": [129352],
    "🥉": [129353],
    "🏅": [127941],
    "🏆": [127942],
    "⚽": [9917],
    "⚾": [9918],
    "🥎": [129358],
    "🏀": [127936],
    "🏐": [127952],
    "🏈": [127944],
    "🏉": [127945],
    "🎾": [127934],
    "🥅": [129349],
    "🏸": [127992],
    "🥍": [129357],
    "🏏": [127951],
    "🏑": [127953],
    "🏒": [127954],
    "🥌": [129356],
    "🛷": [128759],
    "🎿": [127935],
    "🛼": [128764],
    "🩰": [129648],
    "🛹": [128761],
    "⛳": [9971],
    "🎯": [127919],
    "🏹": [127993],
    "🥏": [129359],
    "🪃": [129667],
    "🪁": [129665],
    "🤿": [129343],
    "🎽": [127933],
    "🥋": [129355],
    "🥊": [129354],
    "🎱": [127921],
    "🏓": [127955],
    "🎳": [127923],
    "🪀": [129664],
    "🧩": [129513],
    "🎮": [127918],
    "🎲": [127922],
    "🎰": [127920],
    "🎴": [127924],
    "🀄": [126980],
    "🃏": [127183],
    "🪄": [129668],
    "📷": [128247],
    "🎨": [127912],
    "🪡": [129697],
    "🧵": [129525],
    "🧶": [129526],
    "🎹": [127929],
    "🎷": [127927],
    "🎺": [127930],
    "🎸": [127928],
    "🪕": [129685],
    "🎻": [127931],
    "🪘": [129688],
    "🥁": [129345],
    "🪗": [129687],
    "🎤": [127908],
    "🎧": [127911],
    "📺": [128250],
    "🎬": [127916],
    "🎭": [127917],
    "📱": [128241],
    "🔋": [128267],
    "🪫": [129707],
    "💿": [128191],
    "💾": [128190],
    "💸": [128184],
    "💡": [128161],
    "🧼": [129532],
    "🧦": [129510],
    "👑": [128081],
    "💎": [128142],
    "📚": [128218],
    "📰": [128240],
    "🔎": [128270],
    "🧿": [129535],
    "🔮": [128302],
    "🔒": [128274],
    "♈": [9800],
    "♉": [9801],
    "♊": [9802],
    "♋": [9803],
    "♌": [9804],
    "♍": [9805],
    "♎": [9806],
    "♏": [9807],
    "♐": [9808],
    "♑": [9809],
    "♒": [9810],
    "♓": [9811],
    "⛎": [9934],
    "❗": [10071],
    "❓": [10067],
    "🆘": [127384],
    "📴": [128244],
    "🔈": [128264],
    "✅": [9989],
    "🆕": [127381],
    "🆓": [127379],
    "🆙": [127385],
    "🆗": [127383],
    "🆒": [127378],
    "🚮": [128686],
    "➕": [10133],
    "➖": [10134],
    "➗": [10135],
    "➰": [10160],
    "➿": [10175],
    "💬": [128172],
  };
  List<String> dates = [
    "20201001",
    "20210218",
    "20210521",
    "20210831",
    "20211115",
    "20220110",
    "20220203",
    "20220406",
    "20220506",
  ];
  final String API = "https://www.gstatic.com/android/keyboard/emojikitchen/";
  late List emojiValues = emojis.keys.toList();
  late List emojiKeys = emojis.values.toList();
  late String emoji1 = "😁";
  late String emoji2 = "🥰";
  int _selectedIndex1 = -1;
  int _selectedIndex2 = -1;
  late Image result_image = Image.asset('D:\\Projects\\emojimix\\lib\\a.jpg');
  // late String errorlog = "szLLL";

  void _initimage() {
    setState(() {
      emoji1 = "🐢";
      emoji2 = "🥰";
      _selectedIndex1 = -1;
      _selectedIndex2 = -1;
    });
  }

  // 查找 emoji 编码的函数
  List<int> findEmoji(String emojiCode) {
    Runes runes = emojiCode.runes;
    int emojiNum = runes.first;
    for (var e in emojiKeys) {
      if (e.contains(emojiNum)) {
        return e;
      }
    }
    throw Exception('Emoji not found');
  }

  // 根据emoji1,emoji2生成url并且将result_image设为url对应的图片
  void _generateImage() async {
    List<int>? emoji1Code = findEmoji(emoji1);
    List<int>? emoji2Code = findEmoji(emoji2);

    List<String> urls = [];
    for (String date in dates) {
      urls.add(createUrl(date, emoji1Code, emoji2Code));
      urls.add(createUrl(date, emoji2Code, emoji1Code));
    }

    try {
      for (String url in urls) {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          result_image = Image.network(url);
          return;
        } else {
          result_image = Image.asset('D:\\Projects\\emojimix\\lib\\a.jpg');
        }
      }
    } catch (e) {
      result_image = Image.asset('D:\\Projects\\emojimix\\lib\\a.jpg');
    }
  }

  // 创建 URL 的函数
  String createUrl(String date, List<int> emoji1, List<int> emoji2) {
    String emojiCode(List<int> emoji) {
      return emoji.map((c) => 'u${c.toRadixString(16)}').join('-');
    }

    String u1 = emojiCode(emoji1);
    String u2 = emojiCode(emoji2);
    return '$API$date/$u1/${u1}_$u2.png';
  }

  String getRandomEmoji() {
    Random random = Random();
    int randomIndex = random.nextInt(emojiValues.length);
    return emojiValues[randomIndex];
  }

  // 点击按钮触发方法
  void _toggleListVisibility() {
    setState(() {
      _isListVisible = !_isListVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    // 启动定时器
    _startTimer();
  }

  @override
  void dispose() {
    // 销毁定时器
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _isTipVisible = true;
        _currentTipIndex = (_currentTipIndex + 1) % _tips.length;
      });
      // 5 秒后隐藏提示栏
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _isTipVisible = false;
        });
      });
    });
  }

  void _change_image(id, index) {
    setState(() {
      if (id == 1) {
        emoji1 = emojiValues[index];
      } else {
        emoji2 = emojiValues[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次调用 setState 时都会重新运行此方法。
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      emoji1,
                      style: TextStyle(fontSize: 148), // 放大乌龟图标
                    ),
                    SizedBox(width: 4),
                    Container(
                      height: 170,
                      width: 50,
                      child: ListView.builder(
                        itemCount: emojis.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // 更新第一个列表选中的索引
                                _selectedIndex1 = index;
                                // 调用修改 emoji 的方法
                                _change_image(1, index);
                                _generateImage();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // 如果是选中项，添加背景颜色
                                color:
                                    _selectedIndex1 == index
                                        ? Colors.grey[300]
                                        : null,
                              ),
                              child: Center(
                                child: Text(
                                  emojiValues[index],
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add_circle_sharp, size: 32),
                    SizedBox(width: 10),
                    Container(
                      height: 170,
                      width: 50,
                      child: ListView.builder(
                        itemCount: emojis.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // 更新第一个列表选中的索引
                                _selectedIndex2 = index;
                                // 调用修改 emoji 的方法
                                _change_image(2, index);
                                _generateImage();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // 如果是选中项，添加背景颜色
                                color:
                                    _selectedIndex2 == index
                                        ? Colors.grey[300]
                                        : null,
                              ),
                              child: Center(
                                child: Text(
                                  emojiValues[index],
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      emoji2,
                      style: TextStyle(fontSize: 148), // 放大乌龟图标
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(26),
                      padding: const EdgeInsets.all(6),
                      height: 140,
                      width: 560,

                      decoration: BoxDecoration(
                        // 使用渐变背景
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 248, 255), // 淡蓝色
                            Color.fromARGB(255, 224, 238, 252), // 稍深一点的淡蓝色
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // 边框设置
                        border: Border.all(
                          color: Color.fromARGB(255, 173, 216, 230), // 天蓝色
                          width: 2,
                        ),
                        // 调整圆角大小
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: -2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          // 左边区域
                          Row(
                            children: [
                              Text(emoji1, style: TextStyle(fontSize: 72)),
                              SizedBox(width: 36),
                              Icon(Icons.add, size: 32),
                              SizedBox(width: 26),
                              Text(emoji2, style: TextStyle(fontSize: 72)),
                              SizedBox(width: 36),
                              Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                size: 32,
                              ),
                            ],
                          ),
                          SizedBox(width: 56),
                          // 分隔线
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 16),
                          // 右边区域
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: result_image),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // 新增的工具栏
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 56),
                  padding: const EdgeInsets.all(6),
                  width: 360,
                  decoration: BoxDecoration(
                    // 使用渐变背景，调整颜色
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 230, 220, 250),
                        Color.fromARGB(255, 200, 180, 230),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    // 边框设置
                    border: Border.all(
                      color: Color.fromARGB(255, 150, 180, 220),
                      width: 1,
                    ),
                    // 调整圆角大小
                    borderRadius: BorderRadius.circular(12),
                    // 增强阴影效果
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          // 这里可以添加爱心图标的点击逻辑
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () {
                          // 这里可以添加下载图标的点击逻辑
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          // 这里可以添加循环图标的点击逻辑
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // 这里可以添加 api 按钮的点击逻辑
                        },
                        child: const Text('api'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                const Text('❤️Developed By ： SaltPig233 X FilpWind'),
                SizedBox(height: 16),
                const Text('If you like this app, please give me a star!'),
                // Text(errorlog),
              ],
            ),
          ),
          if (_isTipVisible)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 30,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 205, 255, 243),
                  // 圆角
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  // 阴影
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center, // 确保子组件垂直居中
                  children: [
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _tips[_currentTipIndex],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 0, 0, 0),
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // 新增的列表栏
          if (_isListVisible)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // 添加边框
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                  // 添加圆角
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  // 添加阴影
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(-3, 0),
                    ),
                  ],
                ),
                child: ListView.separated(
                  itemCount: likes.length, // 列表项数量
                  separatorBuilder:
                      (BuildContext context, int index) => Divider(
                        // 分隔线样式
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 0.5,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(likes[index]),
                      onTap: () {
                        // 处理列表项点击事件
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // 点击按钮时调用 _incrementCounter 方法
        onPressed: _toggleListVisibility,
        // 长按按钮时显示的提示信息
        tooltip: '收藏夹',
        child: const Icon(Icons.star),
      ), // 这个尾随逗号使构建方法的自动格式化更美观。
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
