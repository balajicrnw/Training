import '../data/cpu.dart';
import '../data/ram.dart';
import '../data/disk.dart';
import '../data/gpu.dart';
import '../data/internet.dart';
import '../data/ups.dart';
import '../data/computer_state.dart';

class ComputerFacade {
  final CPU cpu = CPU();
  final RAM ram = RAM();
  final Disk disk = Disk();
  final GPU gpu = GPU();
  final Internet internet = Internet();
  final UPS ups = UPS();

  // 🔹 Normal Start
  void startPC(ComputerState state) {
    state.cpuOn = cpu.start();
    ram.load();
    disk.read();
  }

  // 🔹 Start with UPS
  void startWithUPS(ComputerState state) {
    state.upsOn = ups.enable();
    startPC(state);
  }

  // 🔹 Gaming Mode
  void startGaming(ComputerState state) {
    startPC(state);
    state.gpuOn = gpu.start();
  }

  // 🔹 Online Mode
  void startOnline(ComputerState state) {
    startPC(state);
    state.internetOn = internet.connect();
  }

  // 🔹 Shutdown
  void shutdown(ComputerState state) {
    state.cpuOn = cpu.stop();
    state.gpuOn = gpu.stop();
    state.internetOn = internet.disconnect();
    state.upsOn = ups.disable();
  }
}