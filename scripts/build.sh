#!/bin/bash

# Diretórios dos componentes
COMPONENTS=( "header" "swiper" )

# Caminho base para os componentes
BASE_PATH="./src/components"

# Função para gerar o CSS
generate_css() {
  COMPONENT=$1
  INPUT_HTML="$BASE_PATH/$COMPONENT/${COMPONENT}.html"
  INPUT_JS="$BASE_PATH/$COMPONENT/${COMPONENT}.js"
  OUTPUT_FILE="$BASE_PATH/$COMPONENT/output.css"

  echo "Gerando CSS para o componente $COMPONENT..."
  npx tailwindcss -i ./src/input.css -o $OUTPUT_FILE --content $INPUT_HTML,$INPUT_JS
}

# Função para assistir mudanças em um componente
watch_component() {
  COMPONENT=$1
  INPUT_HTML="$BASE_PATH/$COMPONENT/${COMPONENT}.html"
  INPUT_JS="$BASE_PATH/$COMPONENT/${COMPONENT}.js"

  echo "Assistindo mudanças no componente $COMPONENT..."
  npx tailwindcss -i ./src/input.css -o $BASE_PATH/$COMPONENT/output.css --content $INPUT_HTML,$INPUT_JS --watch
}

# Função para mostrar mensagem de ajuda
show_help() {
  echo "Uso: $0 {build|watch} [componente]"
  echo
  echo "Opções:"
  echo "  build         Gera o CSS para um ou todos os componentes."
  echo "  watch         Monitora mudanças nos arquivos de um componente e gera o CSS automaticamente."
  echo
  echo "Componentes disponíveis: ${COMPONENTS[@]}"
  echo
  echo "Exemplos:"
  echo "  $0 build           Gera o CSS para todos os componentes."
  echo "  $0 build header    Gera o CSS apenas para o componente 'header'."
  echo "  $0 watch swiper    Monitora mudanças no componente 'swiper' e gera o CSS automaticamente."
}

# Argumentos do script
ACTION=$1
COMPONENT_NAME=$2

# Verificação dos argumentos
if [[ -z "$ACTION" ]]; then
  echo "Erro: Ação não especificada."
  show_help
  exit 1
fi

if [[ "$ACTION" == "build" || "$ACTION" == "watch" ]]; then
  if [[ -n "$COMPONENT_NAME" ]]; then
    if [[ " ${COMPONENTS[@]} " =~ " $COMPONENT_NAME " ]]; then
      if [[ "$ACTION" == "build" ]]; then
        generate_css $COMPONENT_NAME
      elif [[ "$ACTION" == "watch" ]]; then
        watch_component $COMPONENT_NAME
      fi
    else
      echo "Erro: Componente '$COMPONENT_NAME' não encontrado."
      show_help
      exit 1
    fi
  else
    # Se nenhum componente específico for fornecido, realiza a ação para todos os componentes
    if [[ "$ACTION" == "build" ]]; then
      for COMPONENT in "${COMPONENTS[@]}"; do
        generate_css $COMPONENT
      done
    else
      echo "Erro: Ação 'watch' requer especificação de componente."
      show_help
      exit 1
    fi
  fi
else
  echo "Erro: Ação inválida '$ACTION'."
  show_help
  exit 1
fi
