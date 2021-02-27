#!/bin/sh
echo 'Select an option and press Enter: '
options=("web" "app")
select opt in "${options[@]}"; do
  case $opt in
    "web")
      PROJECT_NAME="dental-case-web"
      break
      ;;
    "app")
      PROJECT_NAME="dental-case-app"
      break
      ;;
  esac
done

# Delete previous project folder
rm -f -r $opt

# Clone 'Dental Case' git repository
git clone https://github.com/GameCase-LAWS/$PROJECT_NAME.git $opt

if [ "$opt" = "app" ];
then
  # Replace 'dental' term for 'clinical'
  sed -i '.bak' 's/dental/clinical/g' $opt/app.json
  sed -i '.bak' 's/Dental/Clinical/g' $opt/app.json
  sed -i '.bak' 's/DENTAL/CLINICAL/g' $opt/app.json

  # Modificar android para ios em app.json
  sed -i '.bak' 's/android-icon/ios-icon/g' $opt/app.json

  # Substituir arquivos de configuração
  cp -r files/config $opt/app

  # Substituir imagens
  cp -r files/assets $opt/app

  # Deletar pasta .git para evitar incidentes
  rm -f -r $opt/.git
fi

if [ "$opt" = "web" ];
then
  # Replace 'dental' term for 'clinical'
  sed -i '.bak' 's/dental/clinical/g' $opt/package.json
  sed -i '.bak' 's/Dental/Clinical/g' $opt/package.json
  sed -i '.bak' 's/DENTAL/CLINICAL/g' $opt/package.json

  sed -i '.bak' 's/Dental/Clinical/g' $opt/public/index.html

  # Substituir favicon
  cp -r files/assets/icons/favicon.png $opt/public/favicon.png

  # Substituir arquivos de configuração
  cp -r files/config $opt/src

  # Substituir imagens
  cp -r files/assets $opt/src

  # Deletar pasta .git para evitar incidentes
  rm -f -r $opt/.git
fi

echo 'Entrando no app/'
cd app/
echo "Instalando os packages..."
npm install

echo "Done! =)"
