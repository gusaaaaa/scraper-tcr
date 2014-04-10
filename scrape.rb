# encoding: UTF-8

require 'easyparser'
require 'open-uri'
require 'net/http'

ep_source = '
  <html>
    <head>{...}</head>
    <body>
      <div id="caja">
        {...}
        <div id="interna">
          <div>{...}</div>
          <div class="contenido">
            {...}
            <div id="mostrar_div">
              <div>{...}</div>
              {many}
                <div>{$date}{/Fecha .+/}{/$date}</div>
                <br />
                <br />
                <div>{$agency}{/.+/}{/$agency}</div>
                <div>{$type}{/.+/}{/$type}</div>
                {...}
                <table>
                    <tr>
                      <td>{...}</td>
                      <td>{$url}{/.+/}{/$url}</td>
                    </tr>
                </table>
                <p><br /><img></img></p>
              {/many}
            </div>
            {...}
          </div>
          {...}
        </div>
        {...}
      </div>
      {...}
    </body>
  </html>
'

easy_parser = EasyParser.new ep_source do |on|
  on.url do |s|
    date = s['date']
    agency = s['agency'].strip
    type = s['type'].strip
    url = /\[.+\]\((.+)\)/.match(s['url'])[1]
    url = "http://www.tcr.gub.uy/#{url}"
    puts "#{date},\"#{agency}\",\"#{type}\",\"#{url}\""
  end
end

params = {}

if ARGV.length > 0
  params['fecha_desde'] = ARGV[0] if ARGV[0]
  if ARGV.length == 2
    params['fecha_hasta'] = ARGV[1] if ARGV[1]
  else
    params['fecha_hasta'] = Date.today.strftime('%d/%m/%Y')
  end
else
  today = Date.today
  a_week_ago = today - 7
  params['fecha_desde'] = a_week_ago.strftime('%d/%m/%Y')
  params['fecha_hasta'] = today.strftime('%d/%m/%Y')
end

url = URI.parse('http://www.tcr.gub.uy/resoluciones.php?tipo=tribunal')
resp, data = Net::HTTP.post_form(url, params)
result, scope = easy_parser.run resp.body
