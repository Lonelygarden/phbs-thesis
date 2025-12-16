# Latexmk configuration for PHBS thesis
# 使用 XeLaTeX 编译，自动处理 biber 参考文献

# 使用 xelatex
$pdf_mode = 5;  # 5 = xelatex
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# 设置 biber 作为参考文献处理器
$biber = 'biber %O %S';

# 输出目录（可选，默认在当前目录）
# $out_dir = 'build';

# 清理时删除的额外文件类型
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml bbl bcf fdb_latexmk fls log aux out toc lof lot';

# 编译最大次数（防止无限循环）
$max_repeat = 5;

# 显示详细信息
$verbose = 0;

# 预览模式（可选）
# $preview_mode = 1;
# $pdf_previewer = 'open -a Preview';  # macOS
