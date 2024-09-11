// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

// Data contract


contract storage{

    struct TotalesProtocol{
        // 1st Storage Slot
        uint64 IndiceAjusteDeposito;
        uint64 IndiceAjustePrestamos;
        uint64 trackingStakingRewardsSupply;
        uint64 trackingStakingRewardsBorrow;
        //2 storage Slot 
        uint104 totalDepostiosBase;
        uint104 totalPrestamosBase;
        uint40 lastUpdateTimeStamp;
        uint8 pauseFlags;
    }

    struct TotalesColateral{
        // 3 rd Storage Slot
        uint128 totalDepositos;
        uint128 _reserved;
    }

    struct Usuario{
        // 4th Storage Slot
        int104 principal; //<0 prestamo >0 deposito
        uint64 seguimientoIndiceAjusteDeposito;
        uint64 seguimientoTasaRewardAcumulado;
        uint16 tokens; // (0->COMP, 1->WBTC,...)
        uint8 _reserved;
    }
    struct ColateralUsuario{
        // 5th Storage Slot
        uint128 balance; //valor en USDC
        uint128 _reserved;
    }

    struct Liquidadores{
        //6th Storage Slot
        uint32 numAbosrciones;
        uint32 numAborvidos;
        uint32 aproxxGastado;
        uint32 reserved;
    }
    // 7 Storage Slot
    uint64 internal IndiceAjusteDeposito;
    uint64 internal IndiceAjustePrestamos;
    uint64 internal trackingStakingRewardsSupply;
    uint64 internal trackingStakingRewardsBorrow;
    //8 storage Slot 
    uint104 internal totalDepostiosBase;
    uint104 internal totalPrestamosBase;
    uint40 internal lastUpdateTimeStamp;
    uint8 internal pauseFlags;


    // 9 Storage Slot
    // Colaterales por token
    mapping(address token => TotalesColateral) public totalsCollateral;
    
    //10 storage slot
    //Permisos de cuentas
    mapping(address cuenta =>mapping(address token => bool permitido)) public permisos;

    //11 storage slot
    mapping(address cuenta => uint conteoAutorizaciones) nonce;

    //12 storage slot
    //Acceso a metricas usuario
    mapping(address cuenta => Usuario) public usuarios;


    //13 storage slot}
    //Acceso a colaterales de usuario
    mapping(address cuenta => ColateralUsuario) public colaterales;

    //14 storage slot
    //Acceso a liquidadores
    mapping(address cuenta => Liquidadores) public liquidadores;
}