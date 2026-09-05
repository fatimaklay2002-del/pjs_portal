import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../admin/ui/admin_dashboard_screen.dart';
import '../../data/model/news_model.dart';
import '../../logic/news_cubit.dart';
import '../../logic/news_state.dart';
import '../widgets/news_action_link_field.dart';
import '../widgets/news_category_dropdown.dart';
import '../widgets/news_featured_checkbox.dart';
import '../widgets/news_image_picker_field.dart';

class NewsAddEditScreen extends StatefulWidget {
  final NewsModel? news;
  const NewsAddEditScreen({super.key, this.news});
  bool get isEdit => news != null;

  @override
  State<NewsAddEditScreen> createState() => _NewsAddEditScreenState();
}

class _NewsAddEditScreenState extends State<NewsAddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  final _linkLabelController = TextEditingController();

  final _categories = const [ 'عام','تدريبي', 'خدمات', 'اجتماعي'];
  String _category = 'عام';
  bool _isFeatured = false;
  File? _selectedImage;
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    final n = widget.news;
    if (n != null) {
      _titleController.text = n.title;
      _contentController.text = n.content;
      _linkController.text = n.actionLink ?? '';
      _linkLabelController.text = n.actionLinkLabel ?? '';
      _category = n.category;
      _isFeatured = n.isFeatured;
      _existingImageUrl = n.imageUrl;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _linkController.dispose();
    _linkLabelController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _selectedImage = File(picked.path));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_titleController.text.trim().isEmpty) {
      context.showErrorSnackBar(AppStrings.errorEnterTitle);
      return;
    }

    final link = _linkController.text.trim();
    final base = NewsModel(
      id: widget.news?.id ?? '',
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      category: _category,
      isFeatured: _isFeatured,
      actionLink: link.isEmpty ? null : link,
      actionLinkLabel: link.isEmpty ? null : _linkLabelController.text.trim(),
      imageUrl: _existingImageUrl,
      createdAt: widget.news?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final cubit = context.read<NewsCubit>();
    widget.isEdit
        ? cubit.updateNews(base, newImageFile: _selectedImage)
        : cubit.addNews(base, imageFile: _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryNavy),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.isEdit ? AppStrings.editNews : AppStrings.addNews,
            style: AppTextStyles.headlineMedium),
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsActionSuccess) {
            context.showSuccessSnackBar(state.message);
            Navigator.of(context).pop();
            AdminDashboardScreen.of(context)?.jumpToTab(0);
          }
          if (state is NewsError) context.showErrorSnackBar(state.message);
        },
        builder: (context, state) {
          final isLoading = state is NewsLoading;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewsImagePickerField(
                    selectedImage: _selectedImage,
                    existingImageUrl: _existingImageUrl,
                    isEdit: widget.isEdit,
                    onTap: _pickImage,
                  ),
                  const SizedBox(height: 16),
                  Text(AppStrings.category, style: AppTextStyles.labelLarge),
                  const SizedBox(height: 8),
                  NewsCategoryDropdown(
                    value: _category,
                    categories: _categories,
                    onChanged: (v) => setState(() => _category = v),
                  ),
                  const SizedBox(height: 16),
                  Text(AppStrings.newsTitle, style: AppTextStyles.labelLarge),
                  const SizedBox(height: 8),
                  CustomTextField(controller: _titleController, hint: AppStrings.enterNewsTitle),
                  const SizedBox(height: 16),
                  Text(AppStrings.newsContent, style: AppTextStyles.labelLarge),
                  const SizedBox(height: 8),
                  CustomTextField(
                      controller: _contentController, hint: AppStrings.enterNewsContent, maxLines: 6),
                  const SizedBox(height: 16),
                  NewsActionLinkFields(
                    linkController: _linkController,
                    labelController: _linkLabelController,
                  ),
                  const SizedBox(height: 16),
                  NewsFeaturedCheckbox(
                    value: _isFeatured,
                    onChanged: (v) => setState(() => _isFeatured = v),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: PrimaryButton(
                      text: widget.isEdit ? AppStrings.update : AppStrings.publish,
                      onPressed: isLoading ? null : _submit,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}