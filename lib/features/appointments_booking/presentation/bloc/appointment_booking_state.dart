class AppointmentBookingState {
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final String? selectedReason;

  bool get isValid =>
      selectedDate != null && selectedTimeSlot != null && selectedReason != null;

  const AppointmentBookingState({
    this.selectedDate,
    this.selectedTimeSlot,
    this.selectedReason,
  });

  AppointmentBookingState copyWith({
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? selectedReason,
  }) {
    return AppointmentBookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedReason: selectedReason ?? this.selectedReason,
    );
  }
}
