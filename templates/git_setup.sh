rm -rf ${repo_dir}
git clone ${src_clone_url} ${repo_dir}
cd ${repo_dir}
git checkout ${repo_branch}
rm -rf .git
cd ${repo_dir}/${sub_dir}; 
git init
git remote add origin ${ssh_clone_url}
git pull origin master
git add .
git commit -m 'initial add'
git push -u origin master