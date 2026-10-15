import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppTextFieldType {
  text,
  email,
  password,
  phone,
  number,
  multiline,
  search,
  url,
  name,
}

class AppTextField extends StatefulWidget {
  // --- Contrôleur & Focus ---
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // --- Labels & Hints ---
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? counterText;

  // --- Type & Clavier ---
  final AppTextFieldType type;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  // --- Icônes ---
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onPrefixTap;

  // --- Comportement ---
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool showCounter;
  final int? maxLength;
  final int maxLines;
  final int minLines;

  // --- Validation ---
  final String? Function(String?)? validator;
  final bool Function(String)? customValidator;
  final String? customValidatorErrorText;

  // --- Callbacks ---
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  // --- Style ---
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final InputDecoration? customDecoration;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? borderColor;
  final double borderRadius;
  final bool filled;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;

  // --- Autocomplete ---
  final Iterable<String>? autofillHints;

  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.counterText,
    this.type = AppTextFieldType.text,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onSuffixTap,
    this.onPrefixTap,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.showCounter = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.customValidator,
    this.customValidatorErrorText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.customDecoration,
    this.contentPadding,
    this.fillColor,
    this.focusedBorderColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.filled = true,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.autofillHints,
  });

  // --- Constructeurs nommés pour les cas courants ---

  /// Champ Email
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool autofocus = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      type: AppTextFieldType.email,
      label: label ?? 'Email',
      hint: hint ?? 'exemple@email.com',
      prefixIcon: Icons.email_outlined,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) return 'Email requis';
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) return 'Email invalide';
            return null;
          },
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      enabled: enabled,
      autofocus: autofocus,
      autofillHints: const [AutofillHints.email],
    );
  }

  /// Champ Mot de passe
  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    TextInputAction? textInputAction,
    bool enabled = true,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      type: AppTextFieldType.password,
      label: label ?? 'Mot de passe',
      hint: hint ?? '••••••••',
      prefixIcon: Icons.lock_outline,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) return 'Mot de passe requis';
            if (value.length < 8) return 'Minimum 8 caractères';
            return null;
          },
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction ?? TextInputAction.done,
      enabled: enabled,
      autofillHints: const [AutofillHints.password],
    );
  }

  /// Champ Téléphone
  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      type: AppTextFieldType.phone,
      label: label ?? 'Téléphone',
      hint: hint ?? '+33 6 00 00 00 00',
      prefixIcon: Icons.phone_outlined,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofillHints: const [AutofillHints.telephoneNumber],
    );
  }

  /// Champ Recherche
  factory AppTextField.search({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hint,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onClear,
    bool autofocus = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      type: AppTextFieldType.search,
      hint: hint ?? 'Rechercher...',
      prefixIcon: Icons.search,
      suffixIcon: Icons.close,
      onSuffixTap: onClear ?? () => controller?.clear(),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      autofocus: autofocus,
      borderRadius: 50,
    );
  }

  /// Zone de texte multilignes
  factory AppTextField.multiline({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    int maxLines = 5,
    int minLines = 3,
    int? maxLength,
    bool showCounter = true,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      type: AppTextFieldType.multiline,
      label: label,
      hint: hint,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      showCounter: showCounter,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  bool get _isPassword => widget.type == AppTextFieldType.password;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode.dispose();
    }
    super.dispose();
  }

  TextInputType get _keyboardType {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.password:
        return TextInputType.visiblePassword;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  TextInputAction get _defaultTextInputAction {
    if (widget.textInputAction != null) return widget.textInputAction!;
    if (widget.type == AppTextFieldType.multiline) return TextInputAction.newline;
    return TextInputAction.next;
  }

  Widget? get _buildSuffixIcon {
    if (_isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
        splashRadius: 20,
      );
    }
    if (widget.suffixIcon != null) {
      if (widget.onSuffixTap != null) {
        return IconButton(
          icon: Icon(widget.suffixIcon, size: 20),
          onPressed: widget.onSuffixTap,
          splashRadius: 20,
        );
      }
      return Icon(widget.suffixIcon, size: 20);
    }
    if (widget.suffix != null) return widget.suffix;
    return null;
  }

  Widget? get _buildPrefixIcon {
    if (widget.prefixIcon != null) {
      if (widget.onPrefixTap != null) {
        return IconButton(
          icon: Icon(widget.prefixIcon, size: 20),
          onPressed: widget.onPrefixTap,
          splashRadius: 20,
        );
      }
      return Icon(widget.prefixIcon, size: 20);
    }
    if (widget.prefix != null) return widget.prefix;
    return null;
  }

  String? _defaultValidator(String? value) {
    if (widget.validator != null) return widget.validator!(value);
    if (widget.customValidator != null && value != null) {
      if (!widget.customValidator!(value)) {
        return widget.customValidatorErrorText ?? 'Valeur invalide';
      }
    }
    return null;
  }

  InputDecoration get _buildDecoration {
    if (widget.customDecoration != null) return widget.customDecoration!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final activeBorderColor = widget.focusedBorderColor ?? colorScheme.primary;
    final defaultBorderColor = widget.borderColor ?? colorScheme.outline.withOpacity(0.4);
    final defaultFillColor = widget.fillColor ??
        (theme.brightness == Brightness.dark
            ? colorScheme.surfaceContainerHighest.withOpacity(0.4)
            : colorScheme.surfaceContainerHighest.withOpacity(0.3));

    final radius = BorderRadius.circular(widget.borderRadius);

    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helperText,
      errorText: widget.errorText,
      counterText: widget.showCounter ? null : '',
      //maxLines: widget.maxLines,

      labelStyle: widget.labelStyle ??
          TextStyle(
            color: _isFocused ? activeBorderColor : colorScheme.onSurfaceVariant,
            fontWeight: _isFocused ? FontWeight.w600 : FontWeight.w400,
          ),
      hintStyle: widget.hintStyle ??
          TextStyle(
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),

      prefixIcon: _buildPrefixIcon,
      suffixIcon: _buildSuffixIcon,

      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      filled: widget.filled,
      fillColor: widget.enabled
          ? defaultFillColor
          : colorScheme.onSurface.withOpacity(0.05),

      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: defaultBorderColor, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: activeBorderColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.12),
          width: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: _keyboardType,
      textInputAction: _defaultTextInputAction,
      obscureText: _isPassword ? _obscureText : false,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      maxLines: _isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      style: widget.textStyle ?? Theme.of(context).textTheme.bodyLarge,
      decoration: _buildDecoration,
      validator: _defaultValidator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}