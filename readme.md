# Add Manuscript Title

Install environment and build manuscript:
```
# repo setup:
git init
# For gitinfo2:
cd .git/hooks
cp /usr/share/texlive/texmf-dist/tex/latex/gitinfo2/post-xxx-sample.txt post-checkout
cp post-checkout post-merge
cp post-checkout post-commit
cd ../..
# remove origin of the template repository
git remote rm origin
# create manuscript
git add .
git commit -m 'initial commit'
# connect to git remote (update url in the following line)
git remote add origin https://github.com/....
git branch -M main
git push -u origin main

# once the repo has been set up, replace url_to_this_repository in the following lines and delete the preceding lines.
# Requirements: make, docker
# To install
make install
# To build simply run make:
make
# Manuscript development guidelines:
# https://github.com/geritwagner/manuscript-guidelines
```
