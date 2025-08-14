#!/bin/bash

# 个性化题库系统 - Vercel部署脚本

echo "🚀 开始部署个性化题库系统到Vercel..."

# 检查是否安装了Vercel CLI
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI未安装"
    echo "请运行: npm install -g vercel"
    exit 1
fi

# 检查必需的文件
echo "📋 检查部署文件..."
required_files=("vercel.json" "api/index.py" "requirements.txt" "app.py")

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ 缺少必需文件: $file"
        exit 1
    fi
done

echo "✅ 所有必需文件存在"

# 登录Vercel（如果需要）
echo "🔐 检查Vercel登录状态..."
if ! vercel whoami &> /dev/null; then
    echo "请登录Vercel:"
    vercel login
fi

# 设置环境变量提醒
echo "⚠️  请确保在Vercel控制台中设置了以下环境变量:"
echo "   - SECRET_KEY"
echo "   - DATABASE_URL"
echo "   - VERCEL=1"

echo ""
read -p "是否已设置环境变量？(y/N): " confirm

if [[ $confirm != [yY] ]]; then
    echo "请先在Vercel控制台中设置环境变量，然后重新运行此脚本"
    exit 1
fi

# 部署到生产环境
echo "🚀 部署到生产环境..."
vercel --prod

echo "✅ 部署完成！"
echo "📱 你的应用现在可以通过Vercel提供的URL访问"
echo "🔧 如有问题，请查看Vercel控制台的日志"
