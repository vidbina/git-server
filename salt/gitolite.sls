install gitolite dependencies:
  pkg.installed:
    - name: gitolite-deps
    - pkgs:
      - git
      - perl-Data-Dumper
ensure git group is present:
  group.present:
    - name: git
    - gid: 917
ensure git user is present:
  user.present:
    - name: git
    - fullname: Git
    #- shell: /usr/bin/git-shell
    - home: /home/git
    - uid: 917
    - gid: 917
    - require:
      - group: git
setup admin SSH key:
  file.managed:
    - user: git
    - name: /home/git/admin.pub
    - source: salt://admin.pub
    - require:
      - user: git
clone the gitolite repo:
  git.latest:
    - name: https://github.com/sitaramc/gitolite
    - rev: master
    - user: git
    - target: /home/git/gitolite
    - require:
      - pkg: gitolite-deps
create the git user's binary dir:
  file.directory:
    - user: git
    - group: git
    - dir_mode: 700
    - name: /home/git/bin
    - require:
      - user: git
run the gitolite installer:
  cmd.run:
    - name: gitolite/install -to /home/git/bin
    - creates: /home/git/bin/gitolite
    - runas: git
    - require:
      - git: https://github.com/sitaramc/gitolite
      - file: /home/git/bin
