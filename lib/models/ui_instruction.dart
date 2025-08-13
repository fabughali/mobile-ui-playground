

class UIInstruction {
  final String component; // e.g., background, title, form, avatar
  final String property;  // e.g., color, visibility, fields
  final dynamic value;    // Color, bool, list, etc.
  
  UIInstruction({
    required this.component, 
    required this.property, 
    this.value,
  });
  
  @override
  String toString() {
    return 'UIInstruction(component: $component, property: $property, value: $value)';
  }
}
