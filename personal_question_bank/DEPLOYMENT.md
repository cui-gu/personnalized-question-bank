# Vercel 部署指南

## 部署准备

### 1. 项目结构确认
确保你的项目结构如下：
```
personal_question_bank/
├── api/
│   └── index.py          # Vercel入口文件
├── templates/            # Flask模板
├── app.py               # 主应用文件
├── models.py            # 数据模型
├── recommendation_engine.py
├── external_platforms.py
├── data_generator.py
├── requirements.txt     # 依赖包
├── vercel.json          # Vercel配置
└── .vercelignore        # 忽略文件
```

### 2. 环境变量配置
在Vercel控制台中设置以下环境变量：

**必需的环境变量：**
- `SECRET_KEY`: Flask密钥（生产环境请使用强密码）
- `DATABASE_URL`: 数据库连接字符串（默认：sqlite:///question_bank.db）
- `VERCEL`: 设为 `1` 表示在Vercel环境中运行

**可选的环境变量：**
- `JUDGE0_API_URL`: Judge0代码执行服务URL
- `JUDGE0_API_KEY`: Judge0 API密钥
- `LEETCODE_SESSION`: LeetCode会话令牌

## 部署步骤

### 方法1：使用Vercel CLI
1. 安装Vercel CLI:
   ```bash
   npm i -g vercel
   ```

2. 在项目根目录登录Vercel:
   ```bash
   vercel login
   ```

3. 部署项目:
   ```bash
   vercel --prod
   ```

### 方法2：使用Vercel Dashboard
1. 访问 [https://vercel.com](https://vercel.com)
2. 点击 "New Project"
3. 连接你的GitHub仓库
4. 选择 `personal_question_bank` 项目
5. 配置环境变量
6. 点击 "Deploy"

## 部署后配置

### 1. 环境变量设置
在Vercel控制台的项目设置中添加以下环境变量：

```
SECRET_KEY=your-very-secure-secret-key-here
DATABASE_URL=sqlite:///question_bank.db
VERCEL=1
```

### 2. 域名配置
- Vercel会自动分配一个域名：`your-project.vercel.app`
- 你也可以配置自定义域名

### 3. 数据库注意事项
- 默认使用SQLite数据库，数据在每次部署时会重置
- 生产环境建议使用PostgreSQL或MySQL
- 可以使用Vercel推荐的数据库服务：
  - [Supabase](https://supabase.com)
  - [PlanetScale](https://planetscale.com)
  - [Railway](https://railway.app)

## 生产数据库配置

### 使用PostgreSQL (推荐)
1. 创建PostgreSQL数据库实例
2. 更新环境变量：
   ```
   DATABASE_URL=postgresql://username:password@host:port/database
   ```
3. 更新requirements.txt添加：
   ```
   psycopg2-binary>=2.9.0
   ```

### 使用MySQL
1. 创建MySQL数据库实例
2. 更新环境变量：
   ```
   DATABASE_URL=mysql://username:password@host:port/database
   ```
3. 更新requirements.txt添加：
   ```
   PyMySQL>=1.1.0
   ```

## 故障排除

### 常见问题

1. **构建失败**
   - 检查requirements.txt中的包版本
   - 确保所有import语句正确
   - 查看Vercel构建日志

2. **运行时错误**
   - 检查环境变量是否正确设置
   - 确保数据库连接字符串正确
   - 查看Vercel函数日志

3. **数据库问题**
   - SQLite在serverless环境中的限制
   - 考虑迁移到云数据库

### 调试技巧

1. 查看部署日志：
   ```bash
   vercel logs your-deployment-url
   ```

2. 本地测试Vercel函数：
   ```bash
   vercel dev
   ```

3. 检查函数执行时间和内存使用

## 性能优化

1. **代码优化**
   - 减少不必要的依赖
   - 优化数据库查询
   - 使用缓存机制

2. **Vercel配置优化**
   - 调整函数超时时间
   - 配置适当的内存限制
   - 启用边缘缓存

## 安全建议

1. **环境变量**
   - 使用强密码作为SECRET_KEY
   - 不要在代码中硬编码敏感信息
   - 定期轮换API密钥

2. **数据库安全**
   - 使用SSL连接
   - 限制数据库访问权限
   - 定期备份数据

3. **应用安全**
   - 启用CORS保护
   - 输入验证和清理
   - 实施适当的身份验证

## 监控和维护

1. **性能监控**
   - 使用Vercel Analytics
   - 监控函数执行时间
   - 跟踪错误率

2. **日志管理**
   - 定期检查应用日志
   - 设置错误警报
   - 监控资源使用情况

3. **更新维护**
   - 定期更新依赖包
   - 监控安全漏洞
   - 备份重要数据
