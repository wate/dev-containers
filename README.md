devcontainer setting skeleton
========================

[Dev Containers][]の設定のひな形置き場

必要なもの
--------------------------

* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
    * Windowsの場合：WSLも必要になります。Microsoft StoreよりWSLをインストールしてください。
* [VSCode(Visual Studio Code)](https://code.visualstudio.com/)
    * 拡張機能：
        * [Remote Development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

[Dev Containers][]の詳細については、以下のページを参照してください。  
[Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)

[Dev Containers]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

利用方法
--------------------------

利用用途に応じ以下の各ディレクトリ内のファイル一式を、
手元の環境にコピーし利用します。

* `ansible`：AnsibleのPlaybookやロールの開発環境
* `php_mariadb`：PHPの動作確認環境
* `redmine`：Redmineの動作確認環境
* `writing_doc_for_mkdoc`：ドキュメントの記載環境
