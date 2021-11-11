# Ответ на вопросы

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea

Ответ:
HASH: aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Comment: Update CHANGELOG.md

Описание решения:
git show -s --pretty=format:'HASH: '%H%n'Comment: '%B  aefea

В данной команде использовалось форматирование с параметром %B (subject and body),
но вполне достаточно было %s, так как комментарий однострочный и body отсутствует, только subject

2. Какому тегу соответствует коммит 85024d3

Ответ:
tag: v0.12.23

Описание решения:
git show -s --format=%D 85024d3

3. Сколько родителей у коммита b8d720? Напишите их хеши.

Ответ: 2
56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

Описание решения:

Можно найти командой с указанием параметра %P (parent hashes):
git show -s --pretty=format:%P b8d720

либо

!/bin/sh
echo "Use only for merge."
echo "Parent hashes($(git rev-parse $1)) commit:"
git rev-parse $(git show $1 | grep Merge: |  awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')

где в качестве первого параметра командной строки передается хеш.
Первая комада и проще и универсальние.

4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

Ответ:

HASH: b14b74c4939dcab573326f4e3ee2a62e23e12f89, Subject: [Website] vmc provider links
HASH: 3f235065b9347a758efadc92295b540ee0a5e26e, Subject: Update CHANGELOG.md
HASH: 6ae64e247b332925b872447e9ce869657281c2bf, Subject: registry: Fix panic when server is unreachable
HASH: 5c619ca1baf2e21a155fcdb4c264cc9e24a2a353, Subject: website: Remove links to the getting started guide's old location
HASH: 06275647e2b53d97d4f0a19a0fec11f6d69820b5, Subject: Update CHANGELOG.md
HASH: d5f9411f5108260320064349b757f55c09bc4b80, Subject: command: Fix bug when using terraform login on Windows
HASH: 4b6d06cc5dcb78af637bbb19c198faff37a066ed, Subject: Update CHANGELOG.md
HASH: dd01a35078f040ca984cdd349f18d0b67e486c35, Subject: Update CHANGELOG.md
HASH: 225466bc3e5f35baa5d07197bbc079345b77525e, Subject: Cleanup after v0.12.23 release
Total commits: 9

Описание решения:

cmd=$(git log v0.12.23..v0.12.24^ --oneline --pretty=format:'HASH: '%H', Subject: '%s) && echo "$cmd" && echo "$cmd" |  wc -l | awk '{print "Total commits: " $1}'

Если требуется исключить из вывода и подсчета сами коммиты c тегами, тогда мы ставим знак ^ после последнего тега для вывода не самого тега, а его родителя и 
на оборот, если необходимо включить в подсчет и вывод коммиты с тегами, то ставим знак ^ после первого тега, для вывода родителя последнего коммита команды git log,
который и есть коммит с тегом. Ответ в этом случае будет соответственно 11.

5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

Ответ:

8c928e835 main: Consult local directories as potential mirrors of providers


Описание решения:

Так как функция была создана и больше не менялась, то можно воспользоваться командой:

git log -S'func providerSource(' --oneline

6. Найдите все коммиты в которых была изменена функция globalPluginDirs

ответ:

commit 78b12205587fe839f10d946ea3fdc06719decb05
Author: Pam Selle <204372+pselle@users.noreply.github.com>
Date:   Mon Jan 13 16:50:05 2020 -0500

    Remove config.go and update things using its aliases
--
commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed Aug 9 17:46:49 2017 -0400

    keep .terraform.d/plugins for discovery
--
commit 41ab0aef7a0fe030e84018973a64135b11abcd70
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed Aug 9 10:34:11 2017 -0400

    Add missing OS_ARCH dir to global plugin paths
--
commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed May 3 22:24:51 2017 -0400

    move some more plugin search path logic to command
--
commit 8364383c359a6b738a436d1b7745ccdce178df47
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 13 18:05:58 2017 -0700

    Push plugin discovery down into command package


Описание решения:

fname=$(git grep -l 'func globalPluginDirs(') && git log -L :globalPluginDirs:$fname | grep 'commit' -A 4

Вывод можно сократить до одной строки на комит убрав "-A 4" в grep

7. Кто автор функции synchronizedWriters?

Ответ:

Martin Atkins

Описание решения:

Функция была удалена в комите bdfea50cc85161dea41be0fe3381fd98731ff786 и поэтому поиск по файлам не дает результата.
Команда git log -S нам соответственно показывает два комита, в котором функция была создана и в котором удалена.
Для того, что бы найти в каком именно комите была создана функция проверим каждый комит на наличие строки "+func synchronizedWriters("

#!/bin/bash
hashs=$(git log -S'func synchronizedWriters(' | grep 'commit' | awk '{print($2)}')
for hash in $hashs
do
  ffunc=$(git show $hash | grep '+func synchronizedWriters(')
  if [ -n "$ffunc" ]; then
        git show -s --pretty=format:'Author: '%an $hash
  fi
done


