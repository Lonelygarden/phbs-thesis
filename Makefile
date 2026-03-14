# ============================================================
# PHBS 硕士学位论文 LaTeX 模板 - Makefile
# ============================================================
#
# 一键编译三个版本:
#   make          - 编译盲审版、答辩版、最终版，全部输出到 output/
#
# 输出文件:
#   output/
#     blind/thesis.pdf     - 盲审版 (隐藏学生、导师，无致谢)
#     defense/thesis.pdf   - 答辩版 (显示学生，隐藏导师，无致谢)
#     final/thesis.pdf     - 最终版 (完整版)
#
# ============================================================

# 目录定义
PARTS_DIR := parts
COVER_DIR := $(PARTS_DIR)/cover
EN_DIR := $(PARTS_DIR)/en
ZH_DIR := $(PARTS_DIR)/zh
SHARED_DIR := shared
PDF_DIR := pdf
OUTPUT_DIR := output

# 编译工具配置
XELATEX := xelatex
XELATEX_FLAGS := -synctex=1 -interaction=nonstopmode -file-line-error
BIBER := biber

# latexmk 配置 (用于 watch 模式)
LATEXMK := latexmk
LATEXMK_FLAGS := -xelatex -synctex=1 -interaction=nonstopmode -file-line-error

# 需要同步到各 parts 的文件
SHARED_FILES := pkuthss.cls pkuthss-utf8.def miscs.tex
SHARED_DIRS := img

# ============================================================
# 默认目标: 编译所有三个版本
# ============================================================

.PHONY: all
all: blind defense final
	@echo ""
	@echo "============================================================"
	@echo "  全部编译完成!"
	@echo "============================================================"
	@echo ""
	@echo "  输出文件:"
	@echo "    $(OUTPUT_DIR)/blind/thesis.pdf    <- 盲审版 (送审用)"
	@echo "    $(OUTPUT_DIR)/defense/thesis.pdf  <- 答辩版 (答辩用)"  
	@echo "    $(OUTPUT_DIR)/final/thesis.pdf    <- 最终版 (存档用)"
	@echo ""

# ============================================================
# 三个阶段的编译目标
# ============================================================

.PHONY: blind
blind:
	@echo ""
	@echo "============================================================"
	@echo "  编译盲审版 (blind)"
	@echo "  - 隐藏: 学生姓名、学号、导师信息"
	@echo "  - 不含: 致谢、原创性声明"
	@echo "============================================================"
	@$(MAKE) build-stage STAGE=blind OUTPUT_SUBDIR=blind

.PHONY: defense
defense:
	@echo ""
	@echo "============================================================"
	@echo "  编译答辩版 (defense)"
	@echo "  - 显示: 学生姓名、学号"
	@echo "  - 隐藏: 导师信息"
	@echo "  - 不含: 致谢、原创性声明"
	@echo "============================================================"
	@$(MAKE) build-stage STAGE=defense OUTPUT_SUBDIR=defense

.PHONY: final
final:
	@echo ""
	@echo "============================================================"
	@echo "  编译最终版 (final)"
	@echo "  - 显示: 所有信息"
	@echo "  - 包含: 致谢、原创性声明"
	@echo "============================================================"
	@$(MAKE) build-stage STAGE=final OUTPUT_SUBDIR=final

# ============================================================
# 编译单个阶段 (内部使用)
# ============================================================

.PHONY: build-stage
build-stage: set-stage sync-all build-all-parts combine-stage
	@echo "  -> $(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/thesis.pdf"

.PHONY: set-stage
set-stage:
	@sed -i.bak 's/\\newcommand{\\stage}{[^}]*}/\\newcommand{\\stage}{$(STAGE)}/' configs.tex
	@rm -f configs.tex.bak

.PHONY: sync-all
sync-all:
	@echo "  [1/6] 同步资源..."
	@cp -f configs.tex $(COVER_DIR)/
	@cp -f configs.tex $(EN_DIR)/
	@cp -f configs.tex $(ZH_DIR)/
	@for f in $(SHARED_FILES); do \
		cp -f $(SHARED_DIR)/$$f $(COVER_DIR)/; \
		cp -f $(SHARED_DIR)/$$f $(EN_DIR)/; \
		cp -f $(SHARED_DIR)/$$f $(ZH_DIR)/; \
	done
	@for d in $(SHARED_DIRS); do \
		cp -rf $(SHARED_DIR)/$$d $(COVER_DIR)/; \
		cp -rf $(SHARED_DIR)/$$d $(EN_DIR)/; \
		cp -rf $(SHARED_DIR)/$$d $(ZH_DIR)/; \
	done
	@cp -f $(PDF_DIR)/版权声明.pdf $(COVER_DIR)/ 2>/dev/null || true
	@cp -f $(PDF_DIR)/原创性声明.pdf $(ZH_DIR)/ 2>/dev/null || true

.PHONY: build-all-parts
build-all-parts:
	@echo "  [2/6] 编译封面 (第1次)..."
	@cd $(COVER_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@echo "  [3/6] 编译英文版 (第1次 + biber + 第2次)..."
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
# 修改为（显示完整错误）
# 	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex
	@cd $(EN_DIR) && $(BIBER) main >/dev/null 2>&1
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@echo "  [4/6] 编译中文版 (第1次 + biber + 第2次)..."
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(ZH_DIR) && $(BIBER) main >/dev/null 2>&1
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@echo "  [5/6] 编译封面 (第2次)..."
	@cd $(COVER_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1

.PHONY: combine-stage
combine-stage:
	@echo "  [6/6] 合并 PDF..."
	@mkdir -p $(OUTPUT_DIR)/$(OUTPUT_SUBDIR)
	@cp $(COVER_DIR)/main.pdf $(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/01-cover.pdf
	@cp $(EN_DIR)/main.pdf $(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/02-en.pdf
	@cp $(ZH_DIR)/main.pdf $(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/03-zh.pdf
	@if command -v pdfunite >/dev/null 2>&1; then \
		pdfunite \
			$(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/01-cover.pdf \
			$(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/02-en.pdf \
			$(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/03-zh.pdf \
			$(OUTPUT_DIR)/$(OUTPUT_SUBDIR)/thesis.pdf; \
	else \
		echo "  警告: pdfunite 未安装，无法合并 PDF"; \
		echo "  安装: brew install poppler (macOS)"; \
	fi

# ============================================================
# 快捷命令 - 只编译某一部分 (调试用)
# ============================================================

.PHONY: cover
cover:
	@$(MAKE) sync-all STAGE=final
	@echo "==> 编译封面 (xelatex x2)..."
	@cd $(COVER_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(COVER_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@mkdir -p $(OUTPUT_DIR)
	@cp $(COVER_DIR)/main.pdf $(OUTPUT_DIR)/cover.pdf
	@echo "==> 完成: $(OUTPUT_DIR)/cover.pdf"

.PHONY: en
en:
	@$(MAKE) sync-all STAGE=final
	@echo "==> 编译英文版 (xelatex + biber + xelatex x2)..."
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(EN_DIR) && $(BIBER) main >/dev/null 2>&1
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(EN_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@mkdir -p $(OUTPUT_DIR)
	@cp $(EN_DIR)/main.pdf $(OUTPUT_DIR)/en.pdf
	@echo "==> 完成: $(OUTPUT_DIR)/en.pdf"

.PHONY: zh
zh:
	@$(MAKE) sync-all STAGE=final
	@echo "==> 编译中文版 (xelatex + biber + xelatex x2)..."
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(ZH_DIR) && $(BIBER) main >/dev/null 2>&1
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@cd $(ZH_DIR) && $(XELATEX) $(XELATEX_FLAGS) main.tex >/dev/null 2>&1
	@mkdir -p $(OUTPUT_DIR)
	@cp $(ZH_DIR)/main.pdf $(OUTPUT_DIR)/zh.pdf
	@echo "==> 完成: $(OUTPUT_DIR)/zh.pdf"

# ============================================================
# 监视模式 - 写作时自动编译
# ============================================================

.PHONY: watch-zh
watch-zh:
	@$(MAKE) sync-all STAGE=final
	@echo "==> 监视中文版，自动编译 (Ctrl+C 退出)..."
	@cd $(ZH_DIR) && $(LATEXMK) -pvc $(LATEXMK_FLAGS) main.tex

.PHONY: watch-en
watch-en:
	@$(MAKE) sync-all STAGE=final
	@echo "==> 监视英文版，自动编译 (Ctrl+C 退出)..."
	@cd $(EN_DIR) && $(LATEXMK) -pvc $(LATEXMK_FLAGS) main.tex

# ============================================================
# 清理
# ============================================================

.PHONY: clean
clean:
	@echo "==> 清理编译缓存..."
	@cd $(COVER_DIR) && $(LATEXMK) -c 2>/dev/null || true
	@cd $(EN_DIR) && $(LATEXMK) -c 2>/dev/null || true
	@cd $(ZH_DIR) && $(LATEXMK) -c 2>/dev/null || true
	@echo "    完成"

.PHONY: cleanall
cleanall: clean
	@echo "==> 清理所有生成文件..."
	@cd $(COVER_DIR) && $(LATEXMK) -C 2>/dev/null || true
	@cd $(EN_DIR) && $(LATEXMK) -C 2>/dev/null || true
	@cd $(ZH_DIR) && $(LATEXMK) -C 2>/dev/null || true
	@rm -rf $(OUTPUT_DIR)
	@# 清理同步的文件
	@rm -f $(COVER_DIR)/configs.tex $(EN_DIR)/configs.tex $(ZH_DIR)/configs.tex
	@rm -f $(COVER_DIR)/miscs.tex $(EN_DIR)/miscs.tex $(ZH_DIR)/miscs.tex
	@rm -f $(COVER_DIR)/pkuthss.cls $(EN_DIR)/pkuthss.cls $(ZH_DIR)/pkuthss.cls
	@rm -f $(COVER_DIR)/pkuthss-utf8.def $(EN_DIR)/pkuthss-utf8.def $(ZH_DIR)/pkuthss-utf8.def
	@rm -rf $(COVER_DIR)/img $(EN_DIR)/img $(ZH_DIR)/img
	@rm -f $(COVER_DIR)/版权声明.pdf $(ZH_DIR)/原创性声明.pdf
	@echo "    完成"

# ============================================================
# 打包
# ============================================================

.PHONY: zip
zip: cleanall
	@echo "==> 打包项目..."
	@zip -r thesis-template.zip . \
		-x "*.git*" \
		-x "*.DS_Store" \
		-x "*.zip" \
		-x "output/*"
	@echo "    已生成 thesis-template.zip"

# ============================================================
# 帮助
# ============================================================

.PHONY: help
help:
	@echo ""
	@echo "PHBS 硕士学位论文 LaTeX 模板"
	@echo "============================="
	@echo ""
	@echo "快速开始:"
	@echo "  1. 编辑 configs.tex 填写你的论文信息"
	@echo "  2. 把签字的 PDF 放到 pdf/ 目录"
	@echo "  3. 在 parts/zh/chap/ 和 parts/en/chap/ 写论文"
	@echo "  4. 运行 make 编译所有版本"
	@echo ""
	@echo "常用命令:"
	@echo "  make          一键编译三个版本 (盲审/答辩/最终)"
	@echo "  make blind    只编译盲审版"
	@echo "  make defense  只编译答辩版"
	@echo "  make final    只编译最终版"
	@echo ""
	@echo "写作时:"
	@echo "  make zh       只编译中文版 (快速预览)"
	@echo "  make en       只编译英文版"
	@echo "  make watch-zh 监视模式，保存时自动编译"
	@echo ""
	@echo "其他:"
	@echo "  make clean    清理编译缓存"
	@echo "  make cleanall 清理所有生成文件"
	@echo "  make zip      打包模板"
	@echo "  make help     显示此帮助"
	@echo ""
	@echo "输出目录: $(OUTPUT_DIR)/"
	@echo "  blind/thesis.pdf    盲审版"
	@echo "  defense/thesis.pdf  答辩版"
	@echo "  final/thesis.pdf    最终版"
	@echo ""
