{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeSynonymInstances #-}

-- | Complex Type: @metadataType@ <http://www.topografix.com/GPX/1/1/#type_metadataType>
module Data.Geo.GPX.Type.Metadata(
  Metadata
, metadata
) where

import Data.Geo.GPX.Type.Person
import Data.Geo.GPX.Type.Copyright
import Data.Geo.GPX.Type.Link
import Data.Geo.GPX.Type.Bounds
import Data.Geo.GPX.Type.Extensions
import Data.Geo.GPX.Lens.NameL
import Data.Geo.GPX.Lens.DescL
import Data.Geo.GPX.Lens.AuthorL
import Data.Geo.GPX.Lens.CopyrightL
import Data.Geo.GPX.Lens.LinksL
import Data.Geo.GPX.Lens.TimeL
import Data.Geo.GPX.Lens.KeywordsL
import Data.Geo.GPX.Lens.BoundsL
import Data.Geo.GPX.Lens.ExtensionsL
import Data.Lens.Common
import Control.Comonad.Trans.Store
import Text.XML.HXT.Arrow.Pickle
import Text.XML.XSD.DateTime

data Metadata = Metadata (Maybe String) (Maybe String) (Maybe Person) (Maybe Copyright) [Link] (Maybe DateTime) (Maybe String) (Maybe Bounds) (Maybe Extensions)
  deriving Eq

metadata ::
  Maybe String -- ^ The name.
  -> Maybe String -- ^ The desc.
  -> Maybe Person -- ^ The author.
  -> Maybe Copyright -- ^ The copyright.
  -> [Link] -- ^ The links (link).
  -> Maybe DateTime -- ^ The time.
  -> Maybe String -- ^ The keywords.
  -> Maybe Bounds -- ^ The bounds.
  -> Maybe Extensions -- ^ The extensions
  -> Metadata
metadata =
  Metadata

instance NameL Metadata where
  nameL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\name -> Metadata name desc author copyright links time keywords bounds extensions) name

instance DescL Metadata where
  descL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\desc -> Metadata name desc author copyright links time keywords bounds extensions) desc

instance AuthorL Metadata (Maybe Person) where
  authorL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\author -> Metadata name desc author copyright links time keywords bounds extensions) author

instance CopyrightL Metadata where
  copyrightL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\copyright -> Metadata name desc author copyright links time keywords bounds extensions) copyright

instance LinksL Metadata where
  linksL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\links -> Metadata name desc author copyright links time keywords bounds extensions) links

instance TimeL Metadata where
  timeL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\time -> Metadata name desc author copyright links time keywords bounds extensions) time

instance KeywordsL Metadata where
  keywordsL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\keywords -> Metadata name desc author copyright links time keywords bounds extensions) keywords

instance BoundsL Metadata where
  boundsL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\bounds -> Metadata name desc author copyright links time keywords bounds extensions) bounds

instance ExtensionsL Metadata where
  extensionsL =
    Lens $ \(Metadata name desc author copyright links time keywords bounds extensions) -> store (\extensions -> Metadata name desc author copyright links time keywords bounds extensions) extensions

instance XmlPickler Metadata where
  xpickle =
    xpWrap (\(a, b, c, d, e, f, g, h, i) -> metadata a b c d e f g h i, \(Metadata a b c d e f g h i) -> (a, b, c, d, e, f, g, h, i)) (xp9Tuple
           (xpOption (xpElem "name" xpText))
           (xpOption (xpElem "desc" xpText))
           (xpOption (xpElem "author" xpickle))
           (xpOption (xpElem "copyright" xpickle))
           (xpList (xpElem "link" xpickle))
           (xpOption (xpElem "time" (xpWrapMaybe (dateTime, show) xpText)))
           (xpOption (xpElem "keywords" xpText))
           (xpOption (xpElem "bounds" xpickle))
           (xpOption (xpElem "extensions" xpickle)))


