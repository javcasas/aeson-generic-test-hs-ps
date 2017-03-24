module Main where

import Prelude (class Show, Unit, bind, (<$>), (<>), ($), show, pure)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Class (liftEff)
import Data.Argonaut.Generic.Aeson as Aeson
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Generic (class Generic, gShow)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either(..), either)

foreign import data_ :: String

newtype GourdId = GourdId { unGourdId :: String }
derive instance genericGourdId :: Generic GourdId
instance showGourdId :: Show GourdId where show = gShow

data GourdProfile = FullProfile {
    _fpId :: GourdId,
    _fpNames :: Array String,
    _fpAge :: Int
  }
  | PreviewProfile {
    _ppId :: GourdId,
    _ppNames :: Array String
  }
derive instance genericGourdProfile :: Generic GourdProfile
instance showGourdProfile :: Show GourdProfile where show = gShow

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  let value = PreviewProfile {_ppId:GourdId { unGourdId: "ASDF" }, _ppNames: ["John", "Doe"]}
  --let value = GourdId { unGourdId: "ASDF" }
  --let theJson = Aeson.encodeJson $ value
  --log $ show theJson
  res <- either (\x -> log $ "Error: " <> x) (\x -> log x) do
    json <- jsonParser $ data_ --theJson
    res <- Aeson.decodeJson json
    pure $ show (res :: GourdProfile)
  log "Finished"
