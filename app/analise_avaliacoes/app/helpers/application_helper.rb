# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_message
    notification = ''
    %i[success info warning error].each do |type|
      next unless flash[type]
  
      notification += "<script>
      Swal.fire({
        type: '#{type}',
        title:'#{flash[type]}',
        showConfirmButton: true,
        icon: '#{type}'
        });
        </script>"
    end
    notification.html_safe
  end


  def tabela_padrao_class
    'table table-xxs table-framed table-hover'
  end

  # Icones
  def icone_edit
    'fa fa-pencil'
  end

  def icone_show
    'fa fa-eye'
  end

  def icone_new
    'fa fa-icon-plus3'
  end

  def icone_search
    'fa fa-magnifying-glass'
  end
  
  def icone_delete
    'fa fa-trash'
  end

  #Botões
  def btn_novo(label, url, tamanho='btn_lg')
    link_to "<i class='#{icone_new}'></i> #{label}".html_safe,
      url,
      title: 'Novo',
      class: "btn btn-outline-dark #{tamanho}"
  end

  def btn_editar(url, args={})
    args[:tamanho] ||= 'btn_lg'
    args[:type] ||= 'default'
    args[:label] ||= t('acoes.editar') 

    if args[:type] == 'heading'
      args[:type] = "btn btn-success"
    else
      args[:type] = "btn btn-success"
    end

    link_to "#{args[:label]} <i class='#{icone_edit}'></i>".html_safe,
      url,
      title: t('acoes.editar'),
      class: "#{args[:type]} #{args[:tamanho]}"
  end

  def btn_visualizar(url, label='', tamanho='btn_lg')
    link_to "<i class='#{icone_show}'></i> #{label}".html_safe,
      url,
      title: t('acoes.visualizar'),
      class: "btn btn-info #{tamanho} text-light"
  end

  def btn_excluir(url, label='', tamanho='btn_lg', confirm='Tem certeza?')
    link_to "<i class='#{icone_delete}'></i> #{label}".html_safe,
      url,
      title: t('acoes.excluir'),
      data: { turbo_method: "delete", turbo_confirm: confirm }, 
      class: "btn btn-danger heading-btn legitRipple #{tamanho}"
  end

  def btn_voltar(label='Voltar')
    link_to "<i class='icon-arrow-left8'></i> #{label}".html_safe, 'javascript:history.back()',
      class: 'btn btn-primary heading-btn legitRipple',
      style: 'margin-left: 5px;'
  end

  def btn_cancelar(label, url)
    link_to "<i class='icon-cross2'></i> #{label}".html_safe,
      url,
      class: 'btn btn-danger heading-btn legitRipple',
      style: 'margin-left: 5px;'
  end

  def btn_submit(new_record)
      button_tag type: 'submit', class: 'btn btn-success' do
        "<i class='icon-checkmark3'></i> #{
          new_record ? 'Cadastrar' : 'Salvar'
        }".html_safe
      end
  end
end