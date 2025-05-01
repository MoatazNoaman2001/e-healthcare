import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as ui;
import 'package:google_fonts/google_fonts.dart';

class DoctorCard extends StatefulWidget {
  final String? name;
  final String? specialty;
  final double? rating;
  final int? experience;
  final String? nextAppointment;
  final VoidCallback onTap;
  final VoidCallback onBook;

  const DoctorCard({
    super.key,
    this.name,
    this.specialty,
    this.rating,
    this.experience,
    this.nextAppointment,
    required this.onTap,
    required this.onBook,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  bool _isTapped = false;

  final Color _primaryColor = const Color(0xFF006272);
  final Color _accentColor = const Color(0xFFE0F7FA);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    Widget content = GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) => setState(() => _isTapped = false),
      onTapCancel: () => setState(() => _isTapped = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(_isTapped ? 0.9 : 0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _primaryColor.withOpacity(_isTapped ? 0.25 : 0.15),
              blurRadius: _isTapped ? 16 : 12,
              spreadRadius: _isTapped ? 4 : 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _accentColor,
                    child: Icon(Icons.person, color: _primaryColor, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name ?? 'unknown_doctor'.tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _primaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.specialty ?? 'unknown_specialization'.tr(),
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: _primaryColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating != null ? widget.rating!.toStringAsFixed(1) : '0.0',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.work, color: _primaryColor.withOpacity(0.7), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              textDirection: ui.TextDirection.rtl,
                              ' سنوات: ${widget.experience ?? '0'} ',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: _primaryColor.withOpacity(0.7), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${'next_appointment'.tr()}: ${widget.nextAppointment ?? 'unknown_date'.tr()}',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: _accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    'book_now'.tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

    if (_fadeAnimation != null) {
      content = FadeTransition(opacity: _fadeAnimation!, child: content);
    }

    return content;
  }
}