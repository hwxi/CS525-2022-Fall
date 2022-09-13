# CS525-2022-Fall
For teaching BU CAS CS525: Compiler Design and Implementation.

## Mirroring this repository

Please create a private repository that mirrors this one and update
frequently.

Step 1:

Please clone the class repository:

```
git clone https://github.com/hwxi/CS525-2022-Fall
```

Step 2:

Please create a repository of your own.
For instance, the following one is created
for my own use:

https://github.com/hwxi/CS525-2022-Fall-hwxi

Then please mirror-push the class repo into your own repo:

```
cd CS525-2022-Fall
git push --mirror https://github.com/hwxi/CS525-2022-Fall-hwxi
git clone https://github.com/hwxi/CS525-2022-Fall-hwxi
cd CS525-2022-Fall-hwxi
git remote add upstream https://hwxi@github.com/hwxi/CS525-2022-Fall.git
```

Step 3:

Please remember to sync with the class repo frequently:

```
git fetch upstream
git merge upstream/main main
```
