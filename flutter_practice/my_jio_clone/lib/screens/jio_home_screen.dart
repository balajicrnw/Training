import 'package:my_jio_clone/ui.dart';

class JioHomeScreen extends StatefulWidget {
  const JioHomeScreen({super.key});

  @override
  State<JioHomeScreen> createState() => _JioHomeScreenState();
}

class _JioHomeScreenState extends State<JioHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              CustomAppBar.jioHome(),
              SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    AppText.large(text: "Extra 1 Month FREE +", isBold: true),
                    AppText.large(
                      text: "Pro Google Gemini (worth",
                      isBold: true,
                    ),
                    AppText.large(text: "₹35,100", isBold: true),
                    SizedBox(height: 8),
                    AppText.medium(
                      text: "Introducing JioHome Cricket season Packs",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Un1yqeKRvB0bP2FV1FFrqwA8ukSlEZaLGY6RhE8j5Q&s=10",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText.medium(
                  text: "Enter details to know more",
                  isBold: true,
                ),
              ),

              AppTextField(text: "Your name *"),
              AppTextField(text: "Mobile number *"),
              AppTextField(text: "PIN Code *"),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: AppButton.blue(text: "Confirm Interest"),
            ),
          ),
        ),
      ],
    );
  }
}
