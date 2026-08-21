import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/generated/assets.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key, required this.db});
  final AppDatabase db;

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature coming soon'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: MyColor.colorDarkBase,
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorPageBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -32),
                      child: _buildProfileCard(context),
                    ),
                    _buildSectionLabel('General'),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesEditprofile,
                      title: 'Edit Profile',
                      subtitle: 'Update your personal information',
                    ),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesNotificationsetting,
                      title: 'Notification Settings',
                      subtitle: 'Manage alerts and reminders',
                    ),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesPaymentsandsubscriptions,
                      title: 'Payments & Subscriptions',
                      subtitle: 'Billing and payment methods',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Support'),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesGiveusfeedback,
                      title: 'Give us Feedback',
                      subtitle: 'Help us improve the app',
                    ),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesGethelp,
                      title: 'Help Center',
                      subtitle: 'FAQs and troubleshooting',
                    ),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesReportconcernsproblems,
                      title: 'Report Concerns',
                      subtitle: 'Report a problem or issue',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Legal'),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesPrivacypolicy,
                      title: 'Privacy Policy',
                    ),
                    _menuTile(
                      context: context,
                      iconAsset: Assets.imagesTermsandservice,
                      title: 'Terms & Conditions',
                    ),
                    const SizedBox(height: 20),
                    _buildLogoutButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 44),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff18A87B), Color(0xff0D9488)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: FontSize.textSizeExtraLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Manage your profile and preferences',
            style: TextStyle(
              color: Colors.white70,
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipOval(
                child: Image.asset(
                  Assets.imagesAvatar,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: MyColor.colorPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: MyColor.colorWhite, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nyein Nyein',
                  style: TextStyle(
                    color: MyColor.colorNeutral900,
                    fontSize: FontSize.textSizeExtraNormal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'nyeinnyein@gmail.com',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColor.colorTextHint,
                    fontSize: FontSize.textSizeSmall,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showComingSoon(context, 'Edit Profile'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: MyColor.colorPrimaryGreenTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.edit, size: 14, color: MyColor.colorPrimary),
                  SizedBox(width: 4),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: MyColor.colorPrimary,
                      fontSize: FontSize.textSizeSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          color: MyColor.colorTextHint,
          fontSize: FontSize.textSizeExtraSmall,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _menuTile({
    required BuildContext context,
    required String iconAsset,
    required String title,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showComingSoon(context, title),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: MyColor.colorPrimaryGreenTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Image.asset(iconAsset, width: 22, height: 22),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: MyColor.colorNeutral900,
                        fontSize: FontSize.textSizeNormalReaderView,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: MyColor.colorTextHint,
                          fontSize: FontSize.textSizeSmall,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: MyColor.colorTextHint,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showComingSoon(context, 'Logout'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffFB7185), Color(0xffF43F5E)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffF43F5E).withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesLogout, width: 20, height: 20),
            const SizedBox(width: 8),
            const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.textSizeNormalReaderView,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
