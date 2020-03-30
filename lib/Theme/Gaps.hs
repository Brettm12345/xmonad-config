{-# LANGUAGE TupleSections #-}

module Theme.Gaps
  ( space,
    spaceBig,
    spaceSmall,
  )
where

import Control.Monad (liftM2)
import Theme.Sizes
  ( bigGap,
    gap,
    smallGap,
  )
import XMonad.Layout.Gaps (Gaps)
import qualified XMonad.Layout.Gaps as G
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Spacing
  ( Border (..),
    Spacing,
    spacingRaw,
  )
import XMonad.Layout.WindowNavigation (Direction2D (D, L, R, U))

uniformBorder :: Integer -> Border
uniformBorder i = Border i i i i

spacing :: Int -> l a -> ModifiedLayout Spacing l a
spacing g = spacingRaw True border True border True
  where
    border = uniformBorder $ fromIntegral g

directions :: [Direction2D]
directions = [U, D, L, R]

type GapsLayout l a = l a -> ModifiedLayout Gaps l a

mkGaps :: Int -> GapsLayout l a
mkGaps i = G.gaps . fmap (,i) $ directions

mkSpace :: Int -> l a -> ModifiedLayout Gaps (ModifiedLayout Spacing l) a
mkSpace = liftM2 (.) mkGaps spacing

-- | Spacing function. Adds gaps and space around screen
space,
  spaceBig,
  spaceSmall ::
    l a -> ModifiedLayout Gaps (ModifiedLayout Spacing l) a
[space, spaceBig, spaceSmall] = mkSpace <$> [gap, bigGap, smallGap]
