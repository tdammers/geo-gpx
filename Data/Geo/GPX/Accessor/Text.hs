module Data.Geo.GPX.Accessor.Text where

class Text a where
  text :: a -> Maybe String
