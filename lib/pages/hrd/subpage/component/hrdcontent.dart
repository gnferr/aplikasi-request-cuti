import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/provider/model/hrdmodel.dart';
import 'package:tugas_akhir/provider/service/hrd_service.dart';

class ContentHrd extends StatelessWidget {
  const ContentHrd({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceHrd>(
      builder: (context, pages, child) {
        return menuDrawer[pages.getIndex].page;
      },
    );
  }
}
