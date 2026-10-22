# 轻叮提醒 v1.2 · Android APK 工程

本项目为可以构建 APK 的 Android 原生工程源码，UI 直接使用已确认的 v1.2 HTML 界面，但提醒调度由 Android `AlarmManager` 负责（非 HTML 页面定时器）。

## 已实现的设计
- 大提醒、小提醒独立间隔（1～10080 分钟）、提醒文字、启用/关闭、倒计时、快捷暂停和提醒时段。
- 提醒通知：附带最多三条未完成且已勾选“附加到提醒”的便签。便签支持新增、编辑、删除、置顶、完成、搜索。
- 提醒声音：清脆叮、柔和咚、双叮、轻提示；从系统文件中选择音乐；使用麦克风录音。新试听会停止旧声音，点击同一个试听可停止；自选音乐最多播放 12 秒。
- 按钮交互音效可单独开关、调节音量。
- 便签和提醒设置保存至 Android 私有 `SharedPreferences`，选择的音乐采用持久 URI 授权，录音保存在应用私有目录。
- 允许开机重新设置提醒；支持 JSON 备份导入/导出（不包含音频）。

## 使用 Android Studio 编译 APK
1. 安装 Android Studio，并准备 Android SDK 35（下载时需联网）。
2. 解压 zip，将 `QuietBell_Android_v1.2` 文件夹用 Android Studio 的 `Open` 打开。
3. 等待 Gradle 同步（如果提示未找到 Gradle Wrapper，请在 IDE 设置中选择本地 Gradle 8.10.2），菜单 `Build > Build Bundle(s) / APK(s) > Build APK(s)`。
4. 安装文件位于 `app/build/outputs/apk/debug/app-debug.apk`。

## 不安装 Android Studio：通过 GitHub Actions 云编译
1. 在 GitHub 创建一个空的新仓库（例如 `quietbell-apk`）。
2. 将本项目**文件夹里的所有文件**上传到仓库根目录，记得包含 `.github/workflows/build-apk.yml` 这个隐藏目录（若使用 GitHub Web Upload，选择文件夹内文件）。
3. 点仓库 `Actions` → `Build Android APK` → `Run workflow`，或推送到 `main` 自动开始。
4. 完成后在这次构建页面的 `Artifacts` 下载 `QuietBell-v1.2-installable-APK`；解压获得 `app-debug.apk`，发送到手机安装。

## Android 提醒权限和限制
- 安卓 13+ 需要允许通知；安卓 12+ 建议在“设置 → 应用 → 特殊应用权限 → 闹钟和提醒”允许“轻叮提醒”准时提醒（APP 设置页含权限入口）。
- 部分厂商的后台省电可能延迟闹钟，仍需在系统电池策略中允许后台。
- Android 省电限制在短间隔（如 1 分钟）时尤其明显；系统闹钟无法保证每分钟严格整点提醒。
- 手机系统的媒体音量、勿扰模式可能影响提醒声音；如果通知声音被系统禁用，应用另行播放声音也可能受系统策略影响。
- 使用 Android 系统播放器播放录音和歌曲，不存在 HTML 页面关闭后定时器停止的问题，但系统可能在收到广播后较早杀死播放进程，因此自选音乐并不保证能播放满 12 秒；后续可加入前台播放服务。

## 工程环境限制说明
本次会话执行环境没有 Android SDK、aapt2 或 Gradle，故未能在这里编译、签名或真机安装验证 APK。此工程不是一个已验证的安装包，首次构建可能暴露需修复的兼容性问题。

## 提醒音效设计
四种提示音由 Android PCM 合成，使用与 HTML 预览一致的频率与轻柔衰减包络；自定义音乐/录音由 Android MediaPlayer 播放。
