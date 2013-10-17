-- | Complex Type: @trkType@ <http://www.topografix.com/GPX/1/1/#type_trkType>
module Data.Geo.Gpx.Trk(
  Trk
, trk
) where

import Data.Geo.Gpx.Trkseg
import Data.Geo.Gpx.Extensions
import Data.Geo.Gpx.Link

data Trk = Trk (Maybe String) (Maybe String) (Maybe String) (Maybe String) [Link] (Maybe Int) (Maybe String) (Maybe Extensions) [Trkseg]
  deriving Eq

trk ::
  Maybe String -- ^ The name.
  -> Maybe String -- ^ The cmt.
  -> Maybe String -- ^ The desc.
  -> Maybe String -- ^ The src.
  -> [Link] -- ^ The links (link).
  -> Maybe Int -- ^ The number.
  -> Maybe String -- ^ The type.
  -> Maybe Extensions -- ^ The extensions.
  -> [Trkseg] -- ^ The track segments (trkseg).
  -> Trk
trk a b c d e f =
  Trk a b c d e (fmap abs f)

{-
instance NameL Trk where
  nameL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\name -> Trk name cmt desc src links number typ extensions trksegs) name

instance CmtL Trk where
  cmtL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\cmt -> Trk name cmt desc src links number typ extensions trksegs) cmt

instance DescL Trk where
  descL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\desc -> Trk name cmt desc src links number typ extensions trksegs) desc

instance SrcL Trk where
  srcL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\src -> Trk name cmt desc src links number typ extensions trksegs) src

instance LinksL Trk where
  linksL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\links -> Trk name cmt desc src links number typ extensions trksegs) links

instance NumberL Trk where
  numberL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\number -> Trk name cmt desc src links number typ extensions trksegs) number

instance TypeL Trk where
  typeL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\typ -> Trk name cmt desc src links number typ extensions trksegs) typ

instance ExtensionsL Trk where
  extensionsL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\extensions -> Trk name cmt desc src links number typ extensions trksegs) extensions

instance TrksegsL Trk where
  trksegsL =
    Lens $ \(Trk name cmt desc src links number typ extensions trksegs) -> store (\trksegs -> Trk name cmt desc src links number typ extensions trksegs) trksegs
-}

{-
instance XmlPickler Trk where
  xpickle =
    xpWrap (\(a, b, c, d, e, f, g, h, i) -> trk a b c d e f g h i, \(Trk a b c d e f g h i) -> (a, b, c, d, e, f, g, h, i)) (xp9Tuple
      (xpOption (xpElem "name" xpText))
      (xpOption (xpElem "cmt" xpText))
      (xpOption (xpElem "desc" xpText))
      (xpOption (xpElem "src" xpText))
      (xpList (xpElem "link" xpickle))
      (xpOption (xpElem "number" xpPrim))
      (xpOption (xpElem "type" xpText))
      (xpOption (xpElem "extensions" xpickle))
      (xpList (xpElem "trkseg" xpickle)))
-}