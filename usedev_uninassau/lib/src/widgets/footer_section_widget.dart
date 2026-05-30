import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

abstract final class FooterSpacing {
  static const horizontal = 32.0;
  static const vertical = 32.0;
  static const section = 36.0;
  static const headingToContent = 16.0;
  static const infoLine = 4.0;
  static const linkLine = 10.0;
  static const logoToTagline = 8.0;
  static const taglineToDivider = 24.0;
  static const dividerToContent = 32.0;
  static const iconRow = 10.0;
}

class FooterSectionWidget extends StatelessWidget {
  const FooterSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MainFooterContent(),
        _CopyrightBar(),
      ],
    );
  }
}

class _MainFooterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.darkNavy),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: FooterSpacing.vertical,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = Responsive.isWide(context);

            final linkColumns = [
              _FooterColumn(
                title: 'Funcionamento',
                items: const [
                  'Segunda a Sexta - 8h às 18h',
                  'sac@usedev.com.br',
                  '0800 541 320',
                ],
                itemSpacing: FooterSpacing.infoLine,
              ),
              _FooterColumn(
                title: 'Institucional',
                items: const [
                  'Sobre nós',
                  'Contato',
                  'Política de Privacidade',
                  'LGPD - Lei de proteção de dados',
                ],
                itemSpacing: FooterSpacing.linkLine,
                isLink: true,
              ),
              _FooterColumn(
                title: 'Informações',
                items: const [
                  'Entregas',
                  'Garantia',
                  'Trocas e devoluções',
                ],
                itemSpacing: FooterSpacing.linkLine,
                isLink: true,
              ),
            ];

            final paymentSection = _FooterIconSection(
              title: 'Formas de Pagamento',
              children: const [
                _FooterAssetIcon(assetPath: 'assets/payments/visa.png'),
                _FooterAssetIcon(assetPath: 'assets/payments/mastercard.png'),
                _FooterAssetIcon(assetPath: 'assets/payments/elo.png'),
                _FooterAssetIcon(assetPath: 'assets/payments/pix.png'),
              ],
            );

            final socialSection = _FooterIconSection(
              title: 'Siga nossas redes:',
              crossAxisAlignment:
                  isWide ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: const [
                _FooterAssetIcon(
                  assetPath: 'assets/social/whatsapp.png',
                  height: 40,
                ),
                _FooterAssetIcon(
                  assetPath: 'assets/social/tiktok.png',
                  height: 40,
                ),
                _FooterAssetIcon(
                  assetPath: 'assets/social/insta.png',
                  height: 40,
                ),
              ],
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        AppColors.limeGreen,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('assets/logo_usedev.png', height: 56),
                    ),
                    const SizedBox(height: FooterSpacing.logoToTagline),
                    Text(
                      'Hora de abraçar seu lado geek!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.limeGreen,
                        fontSize: 16,
                        fontFamily: GoogleFonts.orbitron().fontFamily,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: FooterSpacing.taglineToDivider),
                Container(height: 1, color: AppColors.limeGreen),
                const SizedBox(height: FooterSpacing.dividerToContent),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in linkColumns)
                        Expanded(child: column),
                    ],
                  )
                else
                  ...linkColumns.expand(
                    (column) => [
                      column,
                      const SizedBox(height: FooterSpacing.section),
                    ],
                  ).toList()
                    ..removeLast(),
                const SizedBox(height: FooterSpacing.section),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: paymentSection),
                      Expanded(child: socialSection),
                    ],
                  )
                else ...[
                  paymentSection,
                  const SizedBox(height: FooterSpacing.section),
                  socialSection,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FooterHeading extends StatelessWidget {
  const _FooterHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.orbitron().fontFamily,
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({
    required this.title,
    required this.items,
    required this.itemSpacing,
    this.isLink = false,
  });

  final String title;
  final List<String> items;
  final double itemSpacing;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    final itemStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.3,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterHeading(title),
        const SizedBox(height: FooterSpacing.headingToContent),
        for (var index = 0; index < items.length; index++) ...[
          if (index > 0) SizedBox(height: itemSpacing),
          isLink
              ? InkWell(
                  onTap: () {},
                  child: Text(items[index], style: itemStyle),
                )
              : Text(items[index], style: itemStyle),
        ],
      ],
    );
  }
}

class _FooterIconSection extends StatelessWidget {
  const _FooterIconSection({
    required this.title,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        _FooterHeading(title),
        const SizedBox(height: FooterSpacing.headingToContent),
        Wrap(
          spacing: FooterSpacing.iconRow,
          runSpacing: FooterSpacing.iconRow,
          children: children,
        ),
      ],
    );
  }
}

class _CopyrightBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.copyrightBackground),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Text(
          'Desenvolvido por GRR Developers. Projeto fictício sem fins comerciais.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.copyrightText,
            fontSize: 13,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
    );
  }
}

class _FooterAssetIcon extends StatelessWidget {
  const _FooterAssetIcon({
    required this.assetPath,
    this.height = 32,
  });

  final String assetPath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
