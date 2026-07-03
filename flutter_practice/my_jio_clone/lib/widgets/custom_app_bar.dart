import 'package:flutter/material.dart';
import 'package:my_jio_clone/ui.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.widget});

  final Widget widget;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  factory CustomAppBar.settings() {
    return CustomAppBar(
      widget: Row(
        children: [
          Icon(Icons.arrow_back_ios_rounded),
          SizedBox(width: 10),
          AppText.medium(text: "Profile", isBold: true),
        ],
      ),
    );
  }

  factory CustomAppBar.notifications() {
    return CustomAppBar(
      widget: Row(
        children: [
          Icon(Icons.arrow_back_ios_rounded, color: AppColors.darkBlue),
          SizedBox(width: 10),
          AppText.medium(text: "Notifications", isBold: true),
        ],
      ),
    );
  }

  factory CustomAppBar.jioHome() {
    return CustomAppBar(
      widget: Row(
        children: [
          Icon(Icons.arrow_back_ios_rounded, color: AppColors.darkBlue),
          SizedBox(width: 10),
          Column(
            children: [
              AppText.medium(text: "Get JioHome", isBold: true),
              AppText.medium(text: "9876543210", isBold: true),
            ],
          ),
        ],
      ),
    );
  }

  factory CustomAppBar.recharge() {
    return CustomAppBar(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back_ios_rounded, color: AppColors.darkBlue),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.medium(text: "Recharge 9876543210", isBold: true),
                  AppText.medium(
                    text: "Change number",
                    color: AppColors.darkBlue,
                    isBold: true,
                  ),
                ],
              ),
            ],
          ),

          Icon(Icons.search, color: AppColors.darkBlue),
        ],
      ),
    );
  }

  factory CustomAppBar.home() {
    return CustomAppBar(
      widget: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAACUCAMAAABC4vDmAAAAeFBMVEUKKIX///8AAHcAJYQAAHsAH4IADX4AG4EAEH4AE38AGYCcnsHBxdkAIoOVmL7x8/jf4u2Hj7nT1uTJytytr8yNlLyAhbJocqgdNowSLoi3utF7gK9ZXpwwPI2nqMdHU5k8Qo85SJNgZ6IoMolKWZp1eatHTZXo6fGCSYwjAAAIpklEQVR4nM2ca9+qIAzATUDFNMwsu2ppl+//DY/aTQYYqT2H/c6r55T9HWMbY2BNhgiL4kWyXKX5Yb2xrM36lKerZbKIIzbosVZ/oGCZ5muCsUfdECGrEoRCl3oYk3WeLoP+YP2gou2O2NirYCypVHAetsluG/0V1C3bHzBV4HBoFB/22e33UFGW25hoED24CLbz7Ft9fQcVp2vs6gI9xcXrNP4VFNtebV9bR5y+fPu0/cLutaFYdvRIH6K7EO+YaWNpQrGsxL2U1FIXLnWx9KCCkxcOQ6ol9E7BaFBxYY+A1GDZhY7Jf4ZiM+KPg1SLT2afx/Aj1OIw1Jh4Qfi0GAjF5mTAlJMLIfMPyuqGivZ4bKRa8L7bx3dCBf7X7ltPXL9zGnZBzXWibj9BdN4LiqXjWjigwqnasJRQLPd+h1SLlyupVFDxcUTnJBf/qHKkCqhb+XOmiqpUJIByqEU5uneSCSnlflQKdSt/5AqguHJdyaDiv9FTLaSU2ZUEiv3ext/iHyVzUIRi+R8yVVQSzyBCpT/2T1C89DPU/CchuEuwEHEgVPC7eKcSRGF0BlBRvzXUQCo/6oJi+z9yULy4e9YB9fcGdRdgVhzU4s+cJhBEFioodvpfUBY5MQXU7D8NXi14JoeK9Ss84wsisRSq+NPwAsUvZFCB3f+JKCQuGahoOxCh2LV3vYDQMi/S4nwI6QCo8MoEqKx3HLaPj/rhbZE6A7TlZRCKlX0V5V9as3lh9fcqYckAVNbXHTi7SVvisr+ucMZDsWPPZ71fb+jbVdPlmYU+oLZ9LcqZ8kwTNsCsvC0HpRtgQupVQt+fDoVF0qW/uyOnNlSs56N8+3CZV7I6Yef+F1QKRZ2p0xvKsuMWVKr1ds7uRcBmJFRAZQOg/PQNFa117MDhkp6tr4BaDlh4oHX0gtKaMS5Yddy/5G8h1KDk9e4VGqhc5zk2WMsyq1avB5cibFD+4+ZPqEjHzMMDVMmqiXQYsF6GxL/q1aMHlNbo+cKaMWt+3j1z3nOr2pfUlGb8aqi9jpPylhAquE9Zv1WjYJk9MFEk+ztUdNCaezMB6vEuBKVBU9GJsuuwsasEHaIGaqtlmmooC7kYh5uNb+MRtnDwtoHaab1eB1QD9thwHyx010DppbEfoDQE1fL5U6SGYnpxrwsK+dSn1T+luyOUutWnNxsrdH3arQWbVVB6JtUFZW920yRJsmWKZTGUYC+fJ0HMaomCZL4nuEPJlVFZk6XejFFCIfrewYsKIfD5/nV64xNBdkvO6j1EuqygUr1YpYRyuegHFo/Evsi3hhYXlbaqGGuxXG8eq6Aon6PzTs+7qjccF4p9ljBnll7aoobCoBK+a6nK2XXuNq6k1lylL1asObEVUM8M9iXveYPeCzmFJNJ8nsTWQjPVUECB0Wtn1l7ygamikk0yvLCSYVBCnL49ofBnpopK8us4sXSzVwWUuMR6QHlQhXK5iD/vLa2VZmDXhZrcoYh6i5F/B7GuQleWppv6FsrWayCpJoYQ5dzU0nRTX0KJeapSzlArYW5pZXhfQ7mioliQTROJ/rbQftDB0vSd30GFV/jXqKjbHB3cWtA+YU9grNDa2ugxfQflQEexDb37yyOnhNoSkkxdpC+hbKCObWs9EcI5oOu+B0KhDe8PIqttI+GBD5eS5esvhg+u8Pf8ADlgVQ3rUJufGDpoZIEJN3L4b4CaT2Xopx9AgfRACHA2n2XN+VCDTj9xnpSPxXM4vcCXQJmtcp66YcYToVwVlM9DCQVHuurSZBVmdAMyFX5dHwq+N0jCEt7mqoCsSF2EZSMV0qOmltdv+HjfCgqSVeoiTfIQLS1ARYSw1aSNOoaewUQA8+W/GQ9VJXkyf4oqTxLz1Qoktn809inXFG9/QlHO5p8F6mxVOixZOKDmTQKuNci5wB+/z2S5TYEPX3mjouC/QfJSLRwkSyz/rv3o+laWb4k9RYXS0MMTr4qAGx8Ugook359RL7HExegrSLDkGDrUdX2P5pKOonWoghIWg8uWjSC4ogA7C/ViVFy2t8rAbDHdFUU6E+rSk+eyRQEFv3B5KZ1g+I0pD1Uv24UCR7iREEjkPm3lUG4B/7o9ug71qReKOj/zQ9UUOGApSFheKqQxKQWUZCOCBZXSV1OxthADl9iUgmAMF4OcVB4TRJGjU72H1AIL703RDJYXbZ2VbTV690iggEKW7oEG6MTu5UWYI2tqah12QcFdXLUUYJ49CrHAqPSWbM/opIICLTXq58C4+ChZw+K+raH5ePP4jrBh9CxwhBJ3K3kO3KF4FvfhNohOueT8TJFAatSyEbr//HK3Awxyz20QuGEkmc9Q0lfcEIpm76yD5p90FblC4H1tGMEJcN9062Jq5WAworTSTO8DVbAWk4HX1pqwCUmVTdm1xKd2fAW+Nm7nYcTuOFN0W0l2vN6bkOKGn1uq7WqKuJQbhVz2B97PO6smYXKUpbyt7VoxfUEYJxLLYvEUw0MGyJ69Prk4wBlO7LXkOGQ8daRnFdob27IWAIQ3+2XQNorbYr63ZJuM3iFdTrNsOt+LhlthOeVlGr+HkQXL/UbR5tFuAZA3SyDiYdvZnM7FJS3yDbWxaqsHuZ6DsUMV1W/kOjb2j+eieszasW1PuWPENUuo20rqHjKX+i4ZuDdcn231Pz2Gbyvp34AzqoAGnN6tSmMKbFUa0vY0msCmrgHtb6OJ2P42oFFwLBEbBYe0VI4jspbKQc2nY4is+dTMNl0zG5qNbP02s0neyOMEZh68MPOIipGHecw89mTmATEzj9KZeejQyOOZZh5kNfPIr5mHo808Rm7mgXszryYw8xKHiZHXXUzMvBjEzCtUzLxsZvKLa3kOQ6/lmZh5gdHEyKueajHwUqyJmdeHTYy8aK3BGnIlXf6TK+kaMe/yvkYMvOawEfMuhLyLeVdnPsS4S0ZfYOA61sM417H+A8sCjwik0P36AAAAAElFTkSuQmCC",
                ),
              ),
              Spacer(),
              Icon(Icons.search, color: AppColors.darkBlue),
              SizedBox(width: 16),
              Icon(Icons.qr_code, color: AppColors.darkBlue),
              SizedBox(width: 16),
              Icon(Icons.notifications, color: AppColors.darkBlue),
              SizedBox(width: 16),
              CircleAvatar(
                child: Icon(Icons.person, color: AppColors.darkBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
