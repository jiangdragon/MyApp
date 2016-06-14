package frocessing.color
{
    import frocessing.color.*;

    public class ColorHSV extends Object implements IColor
    {
        private var _h:Number;
        private var _s:Number;
        private var _v:Number;
        private var _r:uint;
        private var _g:uint;
        private var _b:uint;
        private var _a:Number;
        private var update_flg:Boolean;

        public function ColorHSV(_h:Number = 0, _s:Number = 1, _v:Number = 1, _a:Number = 1){
            this.hsv(_h, _s, _v);
            this._a = _a;
        }

        public function clone():ColorHSV{
            return new ColorHSV(this._h, this._s, this._v, this._a);
        }

        public function get value():uint{
            if (this.update_flg) {
                this.update();
            }
            return this._r << 16 | this._g << 8 | this._b;
        }

        public function set value(_value:uint):void{
            this._r = _value>> 16 & 255;
            this._g = _value >> 8 & 255;
            this._b = _value & 255;
            this.update_hsv();
        }

        public function get value32():uint{
            if (this.update_flg){
                this.update();
            }
            return this.a8 << 24 | this._r << 16 | this._g << 8 | this._b;
        }

        public function set value32(_value:uint):void{
            this._r = _value >> 16 & 255;
            this._g = _value >> 8 & 255;
            this._b = _value & 255;
            this._a = (_value >>> 24) / 255;
            this.update_hsv();
        }

        public function get a():Number{
            return this._a;
        }

        public function set a(_a:Number):void{
            this._a = _a;
        }

        private function get a8():uint{
            return Math.round(this._a * 255) & 255;
        }

        public function get r():uint{
            if (this.update_flg){
                this.update();
            }
            return this._r;
        }

        public function set r(_r:uint):void{
            this._r = _r & 255;
            this.update_hsv();
        }

        public function get g():uint{
            if (this.update_flg){
                this.update();
            }
            return this._g;
        }

        public function set g(_g:uint):void{
            this._g = _g & 255;
            this.update_hsv();
        }

        public function get b():uint{
            if (this.update_flg){
                this.update();
            }
            return this._b;
        }

        public function set b(_b:uint):void{
            this._b = _b & 255;
            this.update_hsv();
        }

        public function get h():Number{
            return this._h;
        }

        public function set h(_h:Number):void{
            this._h = _h;
            this.update_flg = true;
        }

        public function get hr():Number{
            return Math.PI * this._h / 180;
        }

        public function set hr(_h:Number):void{
            this._h = 180 * _h / Math.PI;
            this.update_flg = true;
        }

        public function get s():Number{
            return this._s;
        }

        public function set s(_s:Number):void{
            this._s = Math.max(0, Math.min(1, _s));
            this.update_flg = true;
        }

        public function get v():Number{
            return this._v;
        }

        public function set v(_v:Number):void{
            this._v = Math.max(0, Math.min(1, _v));
            this.update_flg = true;
        }

        public function hsv(_h:Number, _s:Number = 1, _v:Number = 1):void{
            this._h = _h;
            this._s = Math.max(0, Math.min(1, _s));
            this._v = Math.max(0, Math.min(1, _v));
            this.update_flg = true;
        }

        public function rgb(param1:uint, param2:uint, param3:uint):void{
            this._r = param1 & 255;
            this._g = param2 & 255;
            this._b = param3 & 255;
            this.update_hsv();
        }

        public function gray(_value:uint):void{
            this._h = 0;
            this._s = 0;
            this._b = _value / 255;
            this._g = _value / 255;;
            this._r = _value / 255;
            this._v = _value / 255;
        }

        public function toRGB():ColorRGB{
            if (this.update_flg){
                this.update();
            }
            return new ColorRGB(this._r, this._g, this._b, this._a);
        }

        private function update():void{
            var h1_int:int = 0;
            if (this._s == 0){
                this._b = Math.round(this._v * 255);
                this._g = Math.round(this._v * 255);
                this._r = Math.round(this._v * 255);
            }else{
				var h1:Number = this._h;
                var temp:Number = h1 % 360;
				h1 %= 360;
				h1 = (temp < 0 ? (h1 + 360) : (h1)) / 60;
                var max:Number = Math.max(0, Math.min(255, this._v * 255));
				h1_int = Math.floor(h1);
                switch(h1_int){
                    case 0:{
                        this._r = max;
                        this._g = Math.round(max * (1 - (1 - h1 + h1_int) * this._s));
                        this._b = Math.round(max * (1 - this._s));
                        break;
                    }
                    case 1:{
                        this._r = Math.round(max * (1 - this._s * h1 + this._s * h1_int));
                        this._g = max;
                        this._b = Math.round(max * (1 - this._s));
                        break;
                    }
                    case 2:{
                        this._r = Math.round(max * (1 - this._s));
                        this._g = max;
                        this._b = Math.round(max * (1 - (1 - h1 + h1_int) * this._s));
                        break;
                    }
                    case 3:{
                        this._r = Math.round(max * (1 - this._s));
                        this._g = Math.round(max * (1 - this._s * h1 + this._s * h1_int));
                        this._b = max;
                        break;
                    }
                    case 4:{
                        this._r = Math.round(max * (1 - (1 - h1 + h1_int) * this._s));
                        this._g = Math.round(max * (1 - this._s));
                        this._b = max;
                        break;
                    }
                    case 5:{
                        this._r = max;
                        this._g = Math.round(max * (1 - this._s));
                        this._b = Math.round(max * (1 - this._s * h1 + this._s * h1_int));
                        break;
                    }
                }
            }
            this.update_flg = false;
        }

        private function update_hsv():void{
            var _max:uint = Math.max(this._r, Math.max(this._g, this._b));
            var _min:uint = Math.min(this._r, Math.min(this._g, this._b));
            var diff:uint = _max - _min;
            if (diff == 0){
                this._h = 0;
                this._s = 0;
                this._v = _max / 255;
            }else{
                this._s = diff / _max;
                this._v = _max / 255;
                if (this._r == _max) {
                    this._h = 60 * (this._g - this._b) / diff;
                }else if (this._g == _max){
                    this._h = 60 * (this._b - this._r) / diff + 120;
                }else{
                    this._h = 60 * (this._r - this._g) / diff + 240;
                }
            }
            this.update_flg = false;
        }

        public function toString():String{
            return "[HSV(" + this._h.toFixed(2) + "," + this._s.toFixed(2) + "," + this._v.toFixed(2) + ")A(" + this._a.toFixed(2) + ")]";
        }

        public function valueOf() : uint{
            return this.value;
        }

    }
}
