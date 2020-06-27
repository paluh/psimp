module CodeGen.Lua.AST where

import Prelude
import Data.Foldable (intercalate)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Tuple (Tuple)

data Stat
  = LocalAssign String Expr
  | Assign Expr Expr
  | If Expr (Array Stat)
  | Return Expr

data Expr
  = Var String
  | Clone Expr
  | Literal Lit
  | Accessor String Expr
  | Indexer Int Expr
  | App Expr Expr
  | Function String (Array Stat)
  | Binary BinOp Expr Expr
  | Unary UnOp Expr
  | Require String
  | Nil

data BinOp
  = Eq
  | Neq
  | Gt
  | Gte
  | Lt
  | Lte
  | Add
  | Sub
  | Mul
  | Div
  | Mod
  | And
  | Or

data UnOp
  = Neg
  | Len
  | Not

data Lit
  = Int Int
  | Number Number
  | Boolean Boolean
  | String String
  | Array (Array Expr)
  | Object (Array (Tuple String Expr))

instance showStat :: Show Stat where
  show (LocalAssign v x) = showCtor "LocalAssign" [ show v, show x ]
  show (Assign a b) = showCtor "Assign" [ show a, show b ]
  show (If cond stats) = showCtor "If" [ show cond, show stats ]
  show (Return x) = showCtor "Return" [ show x ]

instance showExpr :: Show Expr where
  show (Var v) = showCtor "Var" [ show v ]
  show (Clone x) = showCtor "Clone" [ show x ]
  show (Literal lit) = showCtor "Literal" [ show lit ]
  show (Accessor a x) = showCtor "Accessor" [ show a, show x ]
  show (Indexer i x) = showCtor "Indexer" [ show i, show x ]
  show (App f x) = showCtor "App" [ show f, show x ]
  show (Function arg stats) = showCtor "Function" [ show arg, show stats ]
  show (Binary op x y) = showCtor "Binary" [ show op, show x, show y ]
  show (Unary op x) = showCtor "Unary" [ show op, show x ]
  show (Require path) = showCtor "Require" [ show path ]
  show Nil = "Nil"

instance showLit :: Show Lit where
  show (Int i) = showCtor "Int" [ show i ]
  show (Number n) = showCtor "Number" [ show n ]
  show (Boolean b) = showCtor "Boolean" [ show b ]
  show (String s) = showCtor "String" [ show s ]
  show (Array xs) = showCtor "Array" [ show xs ]
  show (Object kvs) = showCtor "Object" [ show kvs ]

showCtor :: String -> Array String -> String
showCtor name args =
  "("
    <> name
    <> " "
    <> intercalate " " args
    <> ")"

derive instance genericBinOp :: Generic BinOp _

derive instance genericUnOp :: Generic UnOp _

instance showBinOp :: Show BinOp where
  show = genericShow

instance showUnOp :: Show UnOp where
  show = genericShow
