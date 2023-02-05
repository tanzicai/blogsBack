cd ~/Documents/DATA/BlogsBack/
hexo clean
hexo g
hexo d
echo "======================================="
echo "博客文件转译上传完成"
echo "======================================="
cd ~/Documents/DATA/BlogsBack/
git add .
git commit -m "关机自动备份-20$(date +%y%m%d)"
git push origin main
echo "======================================="
echo "博客文件转译备份完成"
echo "======================================="