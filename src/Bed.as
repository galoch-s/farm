/**
 * Created by IntelliJ IDEA.
 * User: Gal
 * Date: 02.06.11
 * Time: 14:06
 * To change this template use File | Settings | File Templates.
 */
package {
    import Constants.EnumBed;

    import flash.display.Sprite;

    public class Bed extends Sprite {
        private var _id:int;
        private var _src:String;
        //private var _x:int;
        //private var _y:int;
        private var _run:int;
        private var _type:int;

        public function Bed(type:int){
            _run = 1;
            _type = type;
            switch(type){
                case Constants.EnumBed.BedClover:
                        _src = "clover/";
                break;
                case Constants.EnumBed.BedPotatoes:
                        _src = "potato/";
                break;
                case Constants.EnumBed.BedSunflower:
                        _src = "sunflower/";
                break;
            }
        }

        public function get SRC():String{
            return _src;
        }

        public function get Run():int{
            return _run;
        }

        public function set Run(value:int):void{
            _run = value;
        }

        public function get Type():int{
            return _type;
        }

        public function set ID(value:int):void{
            _id = value;
        }

        public function get ID():int{
            return _id;
        }
    }
}
