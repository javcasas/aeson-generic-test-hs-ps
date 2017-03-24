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
-- gShow fills the gap because of generic instances
--instance showGourdId :: Show GourdId where show = gShow

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
  res <- either (\x -> log $ "Error: " <> x) (\x -> log $ "All ok. Result: " <> x) do
    json <- jsonParser $ data_
    (res :: GourdProfile) <- Aeson.decodeJson json
    pure $ show res
  log "Finished"
