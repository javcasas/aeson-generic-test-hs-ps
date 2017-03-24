{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Lib
    ( someFunc
    ) where

import Data.Aeson 
import GHC.Generics (Generic)
import Data.ByteString.Lazy.Char8 (unpack)

newtype GourdId = GourdId { unGourdId :: String } deriving (Show, Generic, FromJSON, ToJSON)
data GourdProfile = FullProfile {
    _fpId :: GourdId,
    _fpNames :: [String],
    _fpAge :: Int
  }
  | PreviewProfile {
    _ppId :: GourdId,
    _ppNames :: [String]
  } deriving (Show, Generic, FromJSON, ToJSON)

someFunc :: IO ()
someFunc = do
  putStrLn strModule
  where
    prof = FullProfile {
      _fpId = GourdId { unGourdId = "auth0|blahblahblah" },
      _fpNames = ["John", "Doe"],
      _fpAge = 19
    }
    strJson = unpack $ encode prof
    strModule = "exports.data_ = '" ++ strJson ++ "'"
