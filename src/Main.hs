{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Exception (bracket_)
import Network.HTTP.Types.Status
import Network.Wai
import qualified Network.Wai.Handler.Warp as W
import qualified Network.Wai.Handler.WarpTLS as W

app :: Application
app req respond =
  bracket_
    (putStrLn "Allocating scarce resource")
    (putStrLn "Cleaning up")
    (respond $ responseLBS status200 [("Connection", "keep-alive")] "Hello World")

main :: IO ()
main = do
  W.runTLS (W.tlsSettings "certificate.pem" "key.pem") W.defaultSettings app
