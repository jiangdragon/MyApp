package frocessing.math
{

    public class PerlinNoise extends Object
    {
        private var perlin_octaves:int = 4;
        private var perlin_amp_falloff:Number = 0.5;
        private var __perlin:Array;
        private var __random:MTRandom;
        private static const PERLIN_YWRAPB:int = 4;
        private static const PERLIN_YWRAP:int = 1 << PERLIN_YWRAPB;
        private static const PERLIN_ZWRAPB:int = 8;
        private static const PERLIN_ZWRAP:int = 1 << PERLIN_ZWRAPB;
        private static const PERLIN_SIZE:int = 4095;

        public function PerlinNoise()
        {
        }

        public function noise(param1:Number, param2:Number = 0, param3:Number = 0):Number{
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_18:int = 0;
            var _loc_19:int = 0;
            if (this.__perlin == null){
                if (this.__random == null) {
                    this.__random = new MTRandom();
                }
                this.__perlin = new Array((PERLIN_SIZE + 1));
                _loc_18 = 0;
                while (_loc_18 < (PERLIN_SIZE + 1)){
                    
                    this.__perlin[_loc_18] = this.__random.random();
                    _loc_18++;
                }
            }
			param1 = Math.abs(param1);
			param2 = Math.abs(param2);
			param3 = Math.abs(param3);
            var _loc_4:* = int(param1);
            var _loc_5:* = int(param2);
            var _loc_6:* = int(param3);
            var _loc_7:* = param1 - _loc_4;
            var _loc_8:* = param2 - _loc_5;
            var _loc_9:* = param3 - _loc_6;
            var _loc_12:Number = 0;
            var _loc_13:Number = 0.5;
            var _loc_17:int = 0;
            while (_loc_17 < this.perlin_octaves){
                
                _loc_19 = _loc_4 + (_loc_5 << PERLIN_YWRAPB) + (_loc_6 << PERLIN_ZWRAPB);
                _loc_10 = 0.5 * (1 - Math.cos(_loc_7 * Math.PI));
                _loc_11 = 0.5 * (1 - Math.cos(_loc_8 * Math.PI));
                _loc_14 = this.__perlin[int(_loc_19 & PERLIN_SIZE)];
                _loc_14 = _loc_14 + _loc_10 * (this.__perlin[int((_loc_19 + 1) & PERLIN_SIZE)] - _loc_14);
                _loc_15 = this.__perlin[int(_loc_19 + PERLIN_YWRAP & PERLIN_SIZE)];
                _loc_15 = _loc_15 + _loc_10 * (this.__perlin[int(_loc_19 + PERLIN_YWRAP + 1 & PERLIN_SIZE)] - _loc_15);
                _loc_14 = _loc_14 + _loc_11 * (_loc_15 - _loc_14);
                _loc_19 = _loc_19 + PERLIN_ZWRAP;
                _loc_15 = this.__perlin[int(_loc_19 & PERLIN_SIZE)];
                _loc_15 = _loc_15 + _loc_10 * (this.__perlin[int((_loc_19 + 1) & PERLIN_SIZE)] - _loc_15);
                _loc_16 = this.__perlin[int(_loc_19 + PERLIN_YWRAP & PERLIN_SIZE)];
                _loc_16 = _loc_16 + _loc_10 * (this.__perlin[int(_loc_19 + PERLIN_YWRAP + 1 & PERLIN_SIZE)] - _loc_16);
                _loc_15 = _loc_15 + _loc_11 * (_loc_16 - _loc_15);
                _loc_14 = _loc_14 + 0.5 * (1 - Math.cos(_loc_9 * Math.PI)) * (_loc_15 - _loc_14);
                _loc_12 = _loc_12 + _loc_14 * _loc_13;
                _loc_13 = _loc_13 * this.perlin_amp_falloff;
                _loc_4 = _loc_4 << 1;
                _loc_7 = _loc_7 * 2;
                _loc_5 = _loc_5 << 1;
                _loc_8 = _loc_8 * 2;
                _loc_6 = _loc_6 << 1;
                _loc_9 = _loc_9 * 2;
                if (_loc_7 >= 1){
                    _loc_4++;
                    _loc_7 = _loc_7 - 1;
                }
                if (_loc_8 >= 1){
                    _loc_5++;
                    _loc_8 = _loc_8 - 1;
                }
                if (_loc_9 >= 1){
                    _loc_6++;
                    _loc_9 = _loc_9 - 1;
                }
                _loc_17++;
            }
            return _loc_12;
        }

        public function noiseSeed(param1:int):void{
            if (this.__random == null){
                this.__random = new MTRandom();
            }
            this.__random.randomSeed(param1);
            this.__perlin = null;
        }

        public function noiseDetail(param1:uint, param2:Number = 0):void{
            if (param1 > 0){
                this.perlin_octaves = param1;
            }
            if (param2 > 0 && param2 < 1){
                this.perlin_amp_falloff = param2;
            }
        }

    }
}
