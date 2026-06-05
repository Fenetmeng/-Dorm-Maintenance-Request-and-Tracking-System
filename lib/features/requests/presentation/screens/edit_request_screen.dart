import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../data/remote/request_remote_data_source.dart';
import '../../domain/models/maintenance_request_model.dart';
import '../providers/request_provider.dart';

class EditRequestScreen extends ConsumerStatefulWidget {
  const EditRequestScreen({super.key});

  @override
  ConsumerState<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends ConsumerState<EditRequestScreen> {
  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final roomController = TextEditingController();
  final descriptionController = TextEditingController();

  MaintenanceRequestModel? request;
  bool isInitialized = false;
  bool isUploadingPhoto = false;

  PlatformFile? selectedImageFile;
  String? selectedFileName;
  String? currentImageUrl;

  final RequestRemoteDataSource _remoteDataSource = RequestRemoteDataSource();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      final extra = GoRouterState.of(context).extra;

      if (extra is MaintenanceRequestModel) {
        request = extra;

        categoryController.text = extra.category;
        locationController.text = extra.location;
        roomController.text = extra.roomNumber;
        descriptionController.text = extra.description;
        currentImageUrl = extra.imagePath;
      }

      isInitialized = true;
    }
  }

  @override
  void dispose() {
    categoryController.dispose();
    locationController.dispose();
    roomController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedImageFile = result.files.single;
          selectedFileName = result.files.single.name;
        });

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New photo selected'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Photo selection failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveChanges() async {
    final oldRequest = request;

    if (oldRequest == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No request selected'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final category = categoryController.text.trim();
    final location = locationController.text.trim();
    final room = roomController.text.trim();
    final description = descriptionController.text.trim();

    if (category.isEmpty ||
        location.isEmpty ||
        room.isEmpty ||
        description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isUploadingPhoto = true;
    });

    try {
      String? updatedImageUrl = currentImageUrl;

      if (selectedImageFile != null) {
        updatedImageUrl = await _remoteDataSource.uploadImage(
          selectedImageFile!,
        );
      }

      final updatedRequest = oldRequest.copyWith(
        title: '$category Issue',
        category: category,
        location: location,
        roomNumber: room,
        description: description,
        imagePath: updatedImageUrl,
      );

      await ref.read(requestProvider.notifier).updateRequest(updatedRequest);

      if (!mounted) return;

      final state = ref.read(requestProvider);

      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request updated successfully'),
          backgroundColor: Colors.green,
        ),
      );

      context.go('/request-details', extra: updatedRequest);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isUploadingPhoto = false;
        });
      }
    }
  }

  Widget _photoPreview() {
    if (selectedFileName != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryBlue,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            selectedFileName!,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
            ),
          ),
        ],
      );
    }

    if (currentImageUrl != null && currentImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          currentImageUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                'Could not load photo',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
            );
          },
        ),
      );
    }

    return const Center(
      child: Text(
        'Change photo',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF555555),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(requestProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: SizedBox(
          width: 390,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: 72,
                width: double.infinity,
                color: AppColors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (request != null) {
                          context.go('/request-details', extra: request);
                        } else {
                          context.go('/requests');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'EDIT REQUEST',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: request == null
                      ? const Center(
                          child: Text('No request selected'),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: categoryController,
                                decoration: _inputDecoration(),
                              ),

                              const SizedBox(height: 18),

                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: locationController,
                                decoration: _inputDecoration(),
                              ),

                              const SizedBox(height: 18),

                              const Text(
                                'Room Number',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: roomController,
                                decoration: _inputDecoration(),
                              ),

                              const SizedBox(height: 18),

                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: descriptionController,
                                maxLines: 4,
                                decoration: _inputDecoration(),
                              ),

                              const SizedBox(height: 24),

                              Center(
                                child: GestureDetector(
                                  onTap: _pickPhoto,
                                  child: Container(
                                    width: 180,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5E5E5),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: selectedFileName == null
                                            ? const Color(0xFFD6DDE8)
                                            : AppColors.primaryBlue,
                                      ),
                                    ),
                                    child: _photoPreview(),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 34),

                              requestState.isLoading || isUploadingPhoto
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: ElevatedButton(
                                        onPressed: _saveChanges,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryBlue,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Save Changes',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFD6DDE8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}