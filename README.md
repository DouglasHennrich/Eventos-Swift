# Eventos-Swift

Gerenciador de frameworks utilizado
- Cocoapods

Frameworks utilizados no app
- Alamofire
- lottie-ios
- ParallaxHeader
- Kingfisher

Arquitetura adotada
- MVVM
- Coordinator

Swift
- Apple Swift version 5.2.4

Xcode
- Version 11.5


*Para a visualização do loading, foi colocado um `Timer` para poder mostrar como é o estado do app quando ele está fazendo requisições para a API.*

---

## Importante!

Como o app acessa URLs sem SSL, foi preciso remover o ATS, habilitando o app a receber requisições sem criptografia(SSL).

```xml
<key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key>
      <true/>
  </dict>
```
