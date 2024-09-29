#  Configuracion en info.plist

// Para uncluir dominisos con los  que se desea realizar una excepcion:

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>tudominio.com</key> <!-- Agrega el dominio sin el protocolo (http/https) -->
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>

// Para realizar una excepcion general
// Ojo!!!! Solo en fase de pruebas y desarrollo. Eliminar siempre en produccion

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict> 
