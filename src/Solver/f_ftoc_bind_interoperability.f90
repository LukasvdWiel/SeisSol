!>
!! @file
!! This file is part of SeisSol.
!!
!! @author Alex Breuer (breuer AT mytum.de, http://www5.in.tum.de/wiki/index.php/Dipl.-Math._Alexander_Breuer)
!! @author Sebastian Rettenberger (sebastian.rettenberger @ tum.de, http://www5.in.tum.de/wiki/index.php/Sebastian_Rettenberger)
!!
!! @section LICENSE
!! Copyright (c) 2015, SeisSol Group
!! All rights reserved.
!!
!! Redistribution and use in source and binary forms, with or without
!! modification, are permitted provided that the following conditions are met:
!!
!! 1. Redistributions of source code must retain the above copyright notice,
!!    this list of conditions and the following disclaimer.
!!
!! 2. Redistributions in binary form must reproduce the above copyright notice,
!!    this list of conditions and the following disclaimer in the documentation
!!    and/or other materials provided with the distribution.
!!
!! 3. Neither the name of the copyright holder nor the names of its
!!    contributors may be used to endorse or promote products derived from this
!!    software without specific prior written permission.
!!
!! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
!! AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
!! IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
!! ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
!! LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
!! CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
!! SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
!! INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!! CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
!! ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
!! POSSIBILITY OF SUCH DAMAGE.
!!
!! @section DESCRIPTION
!! C++/Fortran-interoperability: Fortran-bindings

#include "Initializer/preProcessorMacros.fpp"

module f_ftoc_bind_interoperability
  implicit none
  !
  ! Fortran to C bindings
  !

  interface c_interoperability_setDomain
    subroutine c_interoperability_setDomain( i_domain ) bind( C, name='c_interoperability_setDomain' )
      use iso_c_binding, only: c_ptr
      implicit none
      type(c_ptr), value :: i_domain
    end subroutine
  end interface

  interface 
    subroutine c_interoperability_setInitialConditionType( type ) bind( C, name='c_interoperability_setInitialConditionType' )
      use iso_c_binding, only: c_char
      implicit none
      character(kind=c_char), dimension(*), intent(in) :: type
    end subroutine
  end interface

  interface 
   subroutine c_interoperability_setTravellingWaveInformation( origin, kVec, ampField ) bind( C, name='c_interoperability_setTravellingWaveInformation')
      use iso_c_binding, only: c_double
      implicit none
      real(kind=c_double), dimension(*), intent(in) :: origin
      real(kind=c_double), dimension(*), intent(in) :: kVec
      real(kind=c_double), dimension(*), intent(in) :: ampField
    end subroutine
  end interface

  interface c_interoperability_setTimeStepWidth
    subroutine c_interoperability_setTimeStepWidth( i_meshId, i_timeStepWidth ) bind( C, name='c_interoperability_setTimeStepWidth' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: i_meshId
      real(kind=c_double), value :: i_timeStepWidth
    end subroutine
  end interface

  interface
    subroutine c_interoperability_initializeClusteredLts( i_clustering, i_enableFreeSurfaceIntegration, usePlasticity ) bind( C, name='c_interoperability_initializeClusteredLts' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value  :: i_clustering
      logical(kind=c_bool), value :: i_enableFreeSurfaceIntegration
      logical(kind=c_bool), value :: usePlasticity
    end subroutine
  end interface

  interface
    subroutine c_interoperability_initializeMemoryLayout(clustering, enableFreeSurfaceIntegration, usePlasticity) bind( C, name='c_interoperability_initializeMemoryLayout' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value  :: clustering
      logical(kind=c_bool), value :: enableFreeSurfaceIntegration
      logical(kind=c_bool), value :: usePlasticity
    end subroutine
  end interface

  interface
    subroutine c_interoperability_initializeEasiBoundaries(fileName) bind( C, name='c_interoperability_initializeEasiBoundaries' )
      use iso_c_binding
      implicit none
      character(kind=c_char), dimension(*), intent(in) :: fileName
    end subroutine
  end interface

  interface
    subroutine c_interoperability_initializeGravitationalAcceleration(gravitationalAcceleration) bind ( C, name='c_interoperability_initializeGravitationalAcceleration')
      use iso_c_binding
      implicit none
      real (kind=c_double), value :: gravitationalAcceleration
    end subroutine
  end interface


  ! Don't forget to add // c_null_char to NRFFileName when using this interface
  interface
    subroutine c_interoperability_setupNRFPointSources( NRFFileName ) bind( C, name='c_interoperability_setupNRFPointSources' )
      use iso_c_binding, only: c_char
      implicit none
      character(kind=c_char), dimension(*), intent(in) :: NRFFileName
    end subroutine
  end interface

  ! Don't forget to add // c_null_char to NRFFileName when using this interface
  interface
    subroutine c_interoperability_setupFSRMPointSources( momentTensor, solidVelocityComponent, pressureComponent, fluidVelocityComponent, numberOfSources, centres, strikes, dips, rakes, onsets, areas, timestep, numberOfSamples, timeHistories ) bind( C, name='c_interoperability_setupFSRMPointSources' )
      use iso_c_binding, only: c_double, c_int
      implicit none
      real(kind=c_double), dimension(*), intent(in) :: momentTensor
      real(kind=c_double), dimension(*), intent(in) :: solidVelocityComponent 
      real(kind=c_double), dimension(*), intent(in) :: pressureComponent 
      real(kind=c_double), dimension(*), intent(in) :: fluidVelocityComponent 
      integer(kind=c_int), value                    :: numberOfSources
      real(kind=c_double), dimension(*), intent(in) :: centres
      real(kind=c_double), dimension(*), intent(in) :: strikes
      real(kind=c_double), dimension(*), intent(in) :: dips
      real(kind=c_double), dimension(*), intent(in) :: rakes
      real(kind=c_double), dimension(*), intent(in) :: onsets
      real(kind=c_double), dimension(*), intent(in) :: areas
      real(kind=c_double), value                    :: timestep
      integer(kind=c_int), value                    :: numberOfSamples
      real(kind=c_double), dimension(*), intent(in) :: timeHistories
    end subroutine
  end interface
  
  ! Don't forget to add // c_null_char to materialFileName when using this interface
  interface
    subroutine c_interoperability_initializeModel(materialFileName, anelasticity, plasticity, anisotropy, poroelasticity, materialVal, bulkFriction, plastCo, iniStress, waveSpeeds) bind( C, name='c_interoperability_initializeModel' )
      use iso_c_binding, only: c_double, c_int, c_char
      implicit none
      character(kind=c_char), dimension(*), intent(in)  :: materialFileName
      integer(kind=c_int), value                        :: anelasticity
      integer(kind=c_int), value                        :: plasticity
      integer(kind=c_int), value                        :: anisotropy, poroelasticity
      real(kind=c_double), dimension(*), intent(out)    :: materialVal, bulkFriction, plastCo, iniStress, waveSpeeds
    end subroutine
  end interface

  interface
    subroutine c_interoperability_addFaultParameter(parameterName, memory) bind( C, name='c_interoperability_addFaultParameter' )
      use iso_c_binding, only: c_double, c_int, c_char
      implicit none
      character(kind=c_char), dimension(*), intent(in)  :: parameterName
      real(kind=c_double), dimension(*), intent(in)    :: memory
    end subroutine
  end interface

  ! Don't forget to add // c_null_char to modelFileName when using this interface
  interface
    logical(kind=c_bool) function c_interoperability_faultParameterizedByTraction(modelFileName) bind( C, name='c_interoperability_faultParameterizedByTraction' )
      use iso_c_binding, only: c_char, c_bool
      implicit none
      character(kind=c_char), dimension(*), intent(in)  :: modelFileName
    end function
  end interface

  ! Don't forget to add // c_null_char to modelFileName when using this interface
  interface
    logical(kind=c_bool) function c_interoperability_nucleationParameterizedByTraction(modelFileName) bind( C, name='c_interoperability_nucleationParameterizedByTraction' )
      use iso_c_binding, only: c_char, c_bool
      implicit none
      character(kind=c_char), dimension(*), intent(in)  :: modelFileName
    end function
  end interface

  ! Don't forget to add // c_null_char to modelFileName when using this interface
  interface
    subroutine c_interoperability_initializeFault(modelFileName, gpwise, bndPoints, numberOfBndPoints) bind( C, name='c_interoperability_initializeFault' )
      use iso_c_binding, only: c_double, c_int, c_char
      implicit none
      character(kind=c_char), dimension(*), intent(in)  :: modelFileName
      integer(kind=c_int), value                        :: gpwise, numberOfBndPoints
      real(kind=c_double), dimension(*), intent(in )    :: bndPoints
    end subroutine
  end interface

  interface c_interoperability_setMaterial
    subroutine c_interoperability_setMaterial( i_elem, i_side, i_materialVal, i_numMaterialVals ) bind( C, name='c_interoperability_setMaterial' )
    use iso_c_binding
    implicit none
    integer(kind=c_int), value :: i_elem
    integer(kind=c_int), value :: i_side
    real(kind=c_double), dimension(*), intent(in) :: i_materialVal
    integer(kind=c_int), value :: i_numMaterialVals
    end subroutine
  end interface

  interface c_interoperability_setInitialLoading
    subroutine c_interoperability_setInitialLoading( i_meshId, i_initialLoading ) bind( C, name='c_interoperability_setInitialLoading' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: i_meshId
      real(kind=c_double), dimension(*), intent(in) :: i_initialLoading
    end subroutine
  end interface


  interface c_interoperability_setPlasticParameters
    subroutine c_interoperability_setPlasticParameters( i_meshId, i_plasticParameters ) bind( C, name='c_interoperability_setPlasticParameters' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: i_meshId
      real(kind=c_double), dimension(*), intent(in) :: i_plasticParameters
    end subroutine
  end interface

  interface c_interoperability_setTv
    subroutine c_interoperability_setTv( tv ) bind( C, name='c_interoperability_setTv' )
      use iso_c_binding, only: c_double
      real(kind=c_double), value :: tv
    end subroutine
  end interface


  interface
    subroutine c_interoperability_initializeCellLocalMatrices(usePlasticity) bind( C, name='c_interoperability_initializeCellLocalMatrices' )
      use iso_c_binding
      implicit none
      logical(kind=c_bool), value :: usePlasticity
    end subroutine
  end interface

  interface
    subroutine c_interoperability_synchronizeCellLocalData( usePlasticity ) bind( C, name='c_interoperability_synchronizeCellLocalData' )
      use iso_c_binding
      implicit none
      logical(kind=c_bool), value :: usePlasticity
    end subroutine
  end interface

  interface c_interoperability_synchronizeCopyLayerDofs
    subroutine c_interoperability_synchronizeCopyLayerDofs() bind( C, name='c_interoperability_synchronizeCopyLayerDofs' )
    end subroutine
  end interface

  interface c_interoperability_enableDynamicRupture
    subroutine c_interoperability_enableDynamicRupture() bind( C, name='c_interoperability_enableDynamicRupture' )
    end subroutine
  end interface

  interface
    subroutine c_interoperability_enableWaveFieldOutput( i_waveFieldInterval, i_waveFieldFilename ) bind( C, name='c_interoperability_enableWaveFieldOutput' )
      use iso_c_binding
      implicit none
      real(kind=c_double), value :: i_waveFieldInterval
      character(kind=c_char), dimension(*), intent(in) :: i_waveFieldFilename
    end subroutine

    subroutine c_interoperability_enableFreeSurfaceOutput( maxRefinementDepth ) bind( C, name='c_interoperability_enableFreeSurfaceOutput' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: maxRefinementDepth
    end subroutine

    subroutine c_interoperability_enableCheckPointing( i_checkPointInterval, i_checkPointFilename, i_checkPointBackend ) bind( C, name='c_interoperability_enableCheckPointing' )
      use iso_c_binding
      implicit none
      real(kind=c_double), value :: i_checkPointInterval
      character(kind=c_char), dimension(*), intent(in) :: i_checkPointFilename
      character(kind=c_char), dimension(*), intent(in) :: i_checkPointBackend
    end subroutine

    subroutine c_interoperability_getIntegrationMask( i_integrationMask ) bind( C, name='c_interoperability_getIntegrationMask' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), dimension(*), intent(out) :: i_integrationMask
    end subroutine

    subroutine c_interoperability_initializeIO( i_mu, i_slipRate1, i_slipRate2, i_slip, i_slip1, i_slip2, i_state, i_strength, &
        i_numSides, i_numBndGP, i_refinement, i_outputMask, i_plasticityMask, i_outputRegionBounds, &
        freeSurfaceInterval, freeSurfaceFilename, xdmfWriterBackend, &
        receiverFileName, receiverSamplingInterval, receiverSyncInterval ) &
        bind( C, name='c_interoperability_initializeIO' )
      use iso_c_binding
      implicit none

      real(kind=c_double), dimension(*), intent(in) :: i_mu
      real(kind=c_double), dimension(*), intent(in) :: i_slipRate1
      real(kind=c_double), dimension(*), intent(in) :: i_slipRate2
      real(kind=c_double), dimension(*), intent(in) :: i_slip
      real(kind=c_double), dimension(*), intent(in) :: i_slip1
      real(kind=c_double), dimension(*), intent(in) :: i_slip2
      real(kind=c_double), dimension(*), intent(in) :: i_state
      real(kind=c_double), dimension(*), intent(in) :: i_strength
      integer(kind=c_int), value                    :: i_numSides
      integer(kind=c_int), value                    :: i_numBndGP
      integer(kind=c_int), value                    :: i_refinement
      integer(kind=c_int), dimension(*), intent(in) :: i_outputMask
      integer(kind=c_int), dimension(7), intent(in) :: i_plasticityMask
      real(kind=c_double), dimension(*), intent(in) :: i_outputRegionBounds
      real(kind=c_double), value                    :: freeSurfaceInterval
      character(kind=c_char), dimension(*), intent(in) :: freeSurfaceFilename
      character(kind=c_char), dimension(*), intent(in) :: xdmfWriterBackend
      character(kind=c_char), dimension(*), intent(in) :: receiverFileName
      real(kind=c_double), value                    :: receiverSamplingInterval
      real(kind=c_double), value                    :: receiverSyncInterval
    end subroutine

    subroutine c_interoperability_projectInitialField() bind( C, name='c_interoperability_projectInitialField' )
      use iso_c_binding
      implicit none
    end subroutine

    subroutine c_interoperability_getDofs( i_meshId, o_dofs ) bind( C, name='c_interoperability_getDofs' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value                     :: i_meshId
      real(kind=c_double), dimension(*), intent(out) :: o_dofs
    end subroutine

    subroutine c_interoperability_getDofsFromDerivatives( i_meshId, o_dofs ) bind( C, name='c_interoperability_getDofsFromDerivatives' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: i_meshId
      real(kind=c_double), dimension(*), intent(out) :: o_dofs
    end subroutine

    subroutine c_interoperability_getNeighborDofsFromDerivatives( i_meshId, i_faceId, o_dofs ) bind( C, name='c_interoperability_getNeighborDofsFromDerivatives' )
      use iso_c_binding
      implicit none
      integer(kind=c_int), value :: i_meshId
      integer(kind=c_int), value :: i_faceId
      real(kind=c_double), dimension(*), intent(out) :: o_dofs
    end subroutine
  end interface

  interface c_interoperability_simulate
    subroutine c_interoperability_simulate( i_finalTime ) bind( C, name='c_interoperability_simulate' )
      use iso_c_binding, only: c_double
      implicit none
      real(kind=c_double), value :: i_finalTime
    end subroutine
  end interface

  interface c_interoperability_finalizeIO
    subroutine c_interoperability_finalizeIO() bind( C, name='c_interoperability_finalizeIO' )
    end subroutine
  end interface

  interface c_interoperability_report_device_memory_status
    subroutine c_interoperability_report_device_memory_status() bind( C, name='c_interoperability_report_device_memory_status' )
    end subroutine
  end interface

  interface c_interoperability_deallocateMemoryManager
    subroutine c_interoperability_deallocateMemoryManager() bind( C, name='c_interoperability_deallocateMemoryManager' )
    end subroutine
  end interface

  interface c_interoperability_TetraDubinerP
      subroutine c_interoperability_TetraDubinerP(phis, xi, eta, zeta, N) bind( C, name='c_interoperability_TetraDubinerP' )
          use iso_c_binding
          implicit none
          real(kind=c_double), dimension(*), intent(out) :: phis
          real(kind=c_double), value :: xi, eta, zeta
          integer(kind=c_int), value :: N
      end subroutine
  end interface

  interface c_interoperability_TriDubinerP
      subroutine c_interoperability_TriDubinerP(phis, xi, eta, N) bind( C, name='c_interoperability_TriDubinerP' )
          use iso_c_binding
          implicit none
          real(kind=c_double), dimension(*), intent(out) :: phis
          real(kind=c_double), value :: xi, eta
          integer(kind=c_int), value :: N
      end subroutine
  end interface

  interface c_interoperability_gradTriDubinerP
      subroutine c_interoperability_gradTriDubinerP(phis, xi, eta, N) bind( C, name='c_interoperability_gradTriDubinerP' )
          use iso_c_binding
          implicit none
          real(kind=c_double), dimension(*), intent(out) :: phis
          real(kind=c_double), value :: xi, eta
          integer(kind=c_int), value :: N
      end subroutine
  end interface

  interface
    real(kind=c_double) function c_interoperability_M2invDiagonal(no) bind( C, name='c_interoperability_M2invDiagonal' )
      use iso_c_binding, only: c_int, c_double
      implicit none
      integer(kind=c_int), intent(in), value  :: no
    end function
  end interface
end module
