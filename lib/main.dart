import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Assign the key to the MaterialApp
      title: 'ReadBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }

}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.deepPurple], // Gradient colors for background
          ),
        ),
        child: Center(
          child: Text(
            'ReadBuddy',
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.deepPurple], // Gradient colors for body
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0, // Adjust the width as needed
                height: 200.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/book.gif'), // Path to your image file in the assets directory
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '“A book is a gift you can open again and again.” ― Garrison Keillor',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  elevation: 0, // Remove button shadow
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple], // Gradient colors for button
                    ),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  elevation: 0, // Remove button shadow
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple], // Gradient colors for button
                    ),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Buddy'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              _buildRoundedTextField(
                controller: usernameController,
                hintText: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(height: 10.0),
              _buildRoundedTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential = await _auth.signInWithEmailAndPassword(
                      email: usernameController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(userCredential: userCredential)),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Login Error'),
                          content: Text('Invalid username or password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(icon, color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
class SignupPage extends StatefulWidget{
  @override
  _signupPageState createState() => _signupPageState();
}
class _signupPageState extends State<SignupPage>{

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Buddy'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              _buildRoundedTextField(
                controller: usernameController,
                hintText: 'Enter your email',
                icon: Icons.email,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
              SizedBox(height: 10.0),
              _buildRoundedTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                icon: Icons.lock,
                isPassword: true,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential = await _auth.createUserWithEmailAndPassword(
                      email: usernameController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(userCredential: userCredential)),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Signup Error'),
                          content: Text('Failed to create an account. Please try again.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    required Color textColor,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textColor),
          icon: Icon(icon, color: iconColor),
          border: InputBorder.none,
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose any controllers or resources here
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}


class HomePage extends StatefulWidget {
  final UserCredential userCredential;

  HomePage({required this.userCredential});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<Book>> booksByGenre = {};
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:mystery+subject:fiction'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Map<String, List<Book>> fetchedBooksByGenre = {};

      for (var item in data['items']) {
        final volumeInfo = item['volumeInfo'];
        final String title = volumeInfo['title'];
        final String imageUrl = volumeInfo['imageLinks']['thumbnail'];
        final String contentUrl = item['id'];

        final Book book = Book(
          title: title,
          imageUrl: imageUrl,
          contentUrl: contentUrl,
        );

        for (var genre in volumeInfo['categories'] ?? []) {
          fetchedBooksByGenre.putIfAbsent(genre, () => []);
          fetchedBooksByGenre[genre]!.add(book);
        }
      }

      setState(() {
        booksByGenre = fetchedBooksByGenre;
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  List<Book> getFilteredBooks() {
    if (_searchQuery.isEmpty) {
      return booksByGenre.values.expand((element) => element).toList();
    }
    return booksByGenre.values.expand((element) => element).where((book) =>
        book.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Book> filteredBooks = getFilteredBooks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.person), // Use the person icon instead of the back arrow
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
        ),
        actions: [

               IconButton(
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    booksByGenre: booksByGenre,
                    userCredential: widget.userCredential,
                  ),
                ),
              );

            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _isSearching
          ? ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          final book = filteredBooks[index];
          return BookWidget(book: book);
        },
      )
          : booksByGenre.isEmpty
          ? Center(child: CircularProgressIndicator())
          : filteredBooks.isEmpty
          ? Center(child: Text('No books available'))
          : ListView.builder(
        itemCount: booksByGenre.length,
        itemBuilder: (context, index) {
          final genre = booksByGenre.keys.elementAt(index);
          final books = booksByGenre[genre]!;
          return _buildGenreSection(genre, books);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(userCredential: widget.userCredential),
              ),
            );
          }
        },
      )

    );
  }

  Widget _buildGenreSection(String genre, List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            genre,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookWidget(book: book);
            },
          ),
        ),
      ],
    );
  }
}
class SearchPage extends StatefulWidget {
  final Map<String, List<Book>> booksByGenre;
  final UserCredential userCredential;

  SearchPage({required this.booksByGenre, required this.userCredential});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  List<Book> _filteredBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(userCredential: widget.userCredential),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return ListTile(
                  title: Text(book.title),
                  // Add more details if needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
          _filteredBooks = _filterBooks(value);
        });
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
    );
  }

  List<Book> _filterBooks(String query) {
    return widget.booksByGenre.values
        .expand((element) => element)
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class UserProfilePage extends StatelessWidget {
  final UserCredential userCredential;

  UserProfilePage({required this.userCredential});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade900, Colors.purple.shade500],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userCredential.user?.displayName ?? "User ID"}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'User UID: ${userCredential.user?.uid ?? "N/A"}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              // Add more user information here if needed
            ],
          ),
        ),
      ),
    );
  }
}


class BookWidget extends StatelessWidget {
  final Book book;

  BookWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the landscape page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandscapePage(book: book),
          ),
        );
      },
      child: Container(
        width: 120.0, // Set a fixed width for the book widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              child: Image.network(
                book.imageUrl,
                height: 150.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: Text(
                book.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                maxLines: 3, // Maximum of 2 lines for the book title
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewMoreButton extends StatelessWidget {
  final String genre;

  ViewMoreButton({required this.genre});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to view more books in this genre
      },
      child: Icon(Icons.arrow_forward),
    );
  }
}
class LandscapePage extends StatelessWidget {
  final Book book;

  LandscapePage({required this.book});

  @override
  Widget build(BuildContext context) {
    // Delayed function to navigate to the content page after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(book: book),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: FadeInWidget(
          duration: Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Turn your mobile landscape for better experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Icon(Icons.screen_rotation, size: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeInWidget extends StatefulWidget {
  final Duration duration;
  final Widget child;

  FadeInWidget({required this.duration, required this.child});

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: widget.child,
    );
  }
}
class Book {
  final String title;
  final String imageUrl;
  final String contentUrl;

  Book({required this.title, required this.imageUrl, required this.contentUrl});
}
class BookDetailsPage extends StatefulWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late List<String> _words;
  late ScrollController _scrollController;
  late double _scrollPosition;
  late double _startPosition;
  bool _readingMode = false;
  bool _isSwipeOptionSelected = false;
  bool _isButtonOptionSelected = false;

  Color _backgroundColor = Colors.white; // Add a variable to track background color

  bool _showAppBar = true;
  double textSize = 20.0; // Declare textSize here


  @override
  void initState() {
    super.initState();
    _words = [];

    fetchBookContent(widget.book.contentUrl).then((content) {
      setState(() {
        _words = content.split(' ');
      });
    });

    _scrollController = ScrollController();
    _scrollPosition = 0.0;
    _startPosition = 0.0;

    // Call the contentPageFadeIn method after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      contentPageFadeIn();
    });
  }

  // Method to control the app bar visibility
  void contentPageFadeIn() {
    setState(() {
      _showAppBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
        title: Text(widget.book.title),
        actions: [
          _buildSettingsButton(context),
        ],
      )
          : PreferredSize(
        child: Container(),
        preferredSize: Size.zero,
      ),
      backgroundColor: _backgroundColor, // Set the background color

      body: GestureDetector(
        onTap: () {
          setState(() {
            _showAppBar = true;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _showAppBar = false;
            });
          });
        },
        onDoubleTap: () {
          setState(() {
            _showAppBar = true;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _showAppBar = false;
            });
          });
        },
        child: Listener(
          onPointerDown: (details) {
            _startPosition = details.localPosition.dx;
          },
          onPointerMove: (details) {
            final currentPosition = details.localPosition.dx;
            setState(() {
              _scrollPosition -= currentPosition - _startPosition;
              _startPosition = currentPosition;
            });
          },
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Row(
                    children: _words.map((word) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          word,
                          style: TextStyle(fontSize: textSize),
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 4,
                      height: 100,
                      color: Colors.blue, // Change color as needed
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 4,
                      height: 100,
                      color: Colors.blue, // Change color as needed
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.5), // Semi-transparent blue color
        ),
        child: PopupMenuButton(
          icon: Icon(Icons.settings),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.format_size),
                title: Text('Text Size'),
              ),
              onTap: () {
                _showTextSizeDialog(context);
              },
            ),

            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.lightbulb),
                title: Text('Reading Mode'),
                trailing: Switch(
                  value: _readingMode,
                  onChanged: (value) {
                    setState(() {
                      _readingMode = value;
                      if (_readingMode) {
                        _backgroundColor = Colors.amber.shade50; // Change background color
                      } else {
                        _backgroundColor = Colors.white; // Reset to default color
                      }
                    });
                  },
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    double newSize = textSize; // Initialize with the current textSize

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text Size'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter text size'),
            onChanged: (value) {
              setState(() {
                newSize = double.tryParse(value) ?? textSize; // Update newSize
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  textSize = newSize; // Update textSize with the new value
                  Navigator.of(context).pop();
                });
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<String> fetchBookContent(String bookId) async {
    try {
      final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$bookId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final description = data['items'][0]['volumeInfo']['description'] ?? '';
        return description;
      } else {
        throw Exception('Failed to load content');
      }
    } catch (e) {
      throw Exception('Failed to load content');
    }
  }



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}