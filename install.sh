# /bin/bash
echo "overwrite below?"
echo "  .vimrc     -> ~/.vimrc"
echo "  .screenrc  -> ~/.screenrc"
echo "  .zshrc     -> ~/.zshrc"
echo "  .dircolors -> ~/.dircolors"
while true; do
      echo "[Y/n]"
      read answer
        case $answer in
            '' | [Yy]* )
                cp .vimrc ~/.vimrc
                cp .zshrc ~/.zshrc
                cp .screenrc ~/.screenrc
                cp .dircolors ~/.dircolors
                source ~/.zshrc
                break;
            ;;
            [Nn]* )
                break;
                ;;
            * )
                echo Please answer Y or N.
                ;;
        esac
done
